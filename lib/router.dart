import 'package:flutter/cupertino.dart';

import 'common_libs.dart';

class ScreenPaths {
  static String splash = '/';
  static String home = '/home';
  static String login = '/login';
  static String register = '/register';
  static String forgotPassword = '/forgot-password';
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
          ScreenPaths.login,
          (state) => const LoginPage(),
        ),
        AppRoute(
          ScreenPaths.register,
          (state) => const RegisterPage(),
        ),
        AppRoute(
          ScreenPaths.forgotPassword,
          (state) => const ForgotPasswordPage(),
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
  _initialDeeplink ??= state.uri.toString();

  return _redirectBasedOnState(state, context);
}

String? _redirectBasedOnState(GoRouterState state, BuildContext context) {
  final currentPath = state.uri.path;

  // Se não estiver autenticado e tentar acessar uma rota que requer autenticação, redirecione para a tela de login.
  if (!session.isAuthenticated && loggedPaths.contains(currentPath)) {
    return ScreenPaths.login;
  }

  // Se não estiver autenticado e tentar acessar uma rota que não requer autenticação, redirecione para a tela inicial.
  if (!session.isAuthenticated && !logoutPaths.contains(currentPath)) {
    return ScreenPaths.home;
  }

  return null;
}

List<String> get logoutPaths => [
      ScreenPaths.login,
      ScreenPaths.register,
      ScreenPaths.forgotPassword,
      ScreenPaths.home,
      ScreenPaths.cart,
      ...products.categories
          .map((category) => ScreenPaths.categoryPath(category)),
    ];

List<String> get loggedPaths => [];
