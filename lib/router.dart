import 'package:flutter/cupertino.dart';
import 'common_libs.dart';
import 'ui/pages/payment_page.dart';

class ScreenPaths {
  static String splash = '/';
  static String home = '/home';
  static String login = '/login';
  static String register = '/register';
  static String forgotPassword = '/forgot-password';
  static String cart = '/cart';
  static String checkout = '/checkout';

  static String categoryPath(String categoryName) => '/category/$categoryName';

  static String paymentPage(String paymentMethod) => '/payment/$paymentMethod';
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
          ScreenPaths.checkout,
          (state) => const CheckoutPage(),
        ),
        AppRoute(
          ScreenPaths.categoryPath(':categoryName'),
          (state) =>
              CategoryPage(categoryName: state.pathParameters['categoryName']!),
        ),
        AppRoute(
          ScreenPaths.paymentPage(':paymentMethod'),
          (state) => const PaymentPage(),
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
  // Se o usuário não estiver autenticado e tentar acessar uma página autenticada
  if (!session.isAuthenticated && loggedPaths.contains(state.uri.path)) {
    // Salvar a URL original para redirecionar após o login
    _initialDeeplink = state.uri.toString();
    return ScreenPaths.login;
  }

  // Se o usuário estiver autenticado e a URL inicial estiver definida, redirecionar para a URL inicial
  if (session.isAuthenticated && _initialDeeplink != null) {
    final tempDeeplink = _initialDeeplink;
    _initialDeeplink = null; // Limpar a URL inicial para futuras navegações
    return tempDeeplink;
  }

  // Se o usuário estiver autenticado e estiver na tela de splash, redirecionar para a tela inicial
  if (session.isAuthenticated && state.uri.path == ScreenPaths.splash) {
    return ScreenPaths.home;
  }

  // Se o usuário não estiver autenticado e estiver na tela de splash, redirecionar para a tela inicial
  if (!session.isAuthenticated && state.uri.path == ScreenPaths.splash) {
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

List<String> get loggedPaths => [
      ScreenPaths.checkout,
      ...PaymentType.values.map(
        (paymentType) => ScreenPaths.paymentPage(
          paymentType.type,
        ),
      ),
    ];
