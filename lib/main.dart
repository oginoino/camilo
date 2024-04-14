import 'package:camilo/mock/products_list_data.dart';

import 'common_libs.dart';

void main() async {
  registerSingletons();

  GoRouter.optionURLReflectsImperativeAPIs = true;

  runApp(const CamiloApp());
}

class CamiloApp extends StatelessWidget {
  const CamiloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mercado do Camilo',
      theme: lightTheme,
      routerDelegate: appRouter.routerDelegate,
      routeInformationProvider: appRouter.routeInformationProvider,
      routeInformationParser: appRouter.routeInformationParser,
      debugShowCheckedModeBanner: false,
    );
  }
}

void registerSingletons() {
  GetIt.I.registerLazySingleton<UiConstants>(() => UiConstants());
  GetIt.I
      .registerLazySingleton<ProductList>(() => ProductListData.productsList);
}

UiConstants get uiConstants => GetIt.I<UiConstants>();
ProductList get products => GetIt.I<ProductList>();
