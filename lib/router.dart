import 'package:flutter/cupertino.dart';

import 'common_libs.dart';

class ScreenPaths {
  static String splash = '/';
  static String home = '/home';
}

final appRouter = GoRouter(
  redirect: _handleRedirect,
  observers: [],
  initialLocation: ScreenPaths.splash,
  routes: [
    ShellRoute(
      builder: (context, router, navigator) {
        return CustomScaffold(
          child: navigator,
        );
      },
      routes: [
        AppRoute(ScreenPaths.splash, (state) => const Scaffold()),
        AppRoute(
          ScreenPaths.home,
          (state) => const HomePage(),
        ),
      ],
    ),
  ],
);

class AppRoute extends GoRoute {
  AppRoute(String path, Widget Function(GoRouterState s) builder,
      {List<GoRoute> routes = const [], this.useFade = true})
      : super(
          path: path,
          routes: routes,
          pageBuilder: (context, state) {
            final pageContent = Scaffold(
              body: builder(state),
              resizeToAvoidBottomInset: true,
            );
            if (useFade) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: pageContent,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            }
            return CupertinoPage(child: pageContent);
          },
        );
  final bool useFade;
}

String? get initialDeeplink => _initialDeeplink;
String? _initialDeeplink;

String? _handleRedirect(BuildContext context, GoRouterState state) {
  // Armazenar o deeplink inicial apenas uma vez.
  _initialDeeplink ??= state.uri.toString();

  // Redirecionar com base no estado de inicialização e autenticação
  return _redirectBasedOnState(state, context);
}

String? _redirectBasedOnState(GoRouterState state, BuildContext context) {
  final String path = state.uri.path;

  return _redirectToHome(path);
}

String? _redirectToHome(String path) {
  return ScreenPaths.home;
}
