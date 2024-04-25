import 'package:flutter/cupertino.dart';

import 'common_libs.dart';

class ScreenPaths {
  static String splash = '/';
  static String home = '/home';
  static String cart = '/cart';

  static String categoryPath(String categoryName) => '/category/$categoryName';
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
        AppRoute(
          ScreenPaths.cart,
          (state) => const CartPage(),
        ),
        AppRoute(
          ScreenPaths.categoryPath(':categoryName'),
          (state) =>
              CategoryPage(categoryName: state.pathParameters['categoryName']!),
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
  if (state.uri.path == ScreenPaths.splash) {
    return ScreenPaths.home;
  }
  return null;
}
