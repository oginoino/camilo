import 'package:firebase_core/firebase_core.dart';
import 'common_libs.dart';
import 'firebase_options.dart';
import 'models/checkout.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GoRouter.optionURLReflectsImperativeAPIs = false;

  registerSingletons();

  await appLogic.bootstrap();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => products),
        ChangeNotifierProvider(create: (_) => productCart),
        ChangeNotifierProvider(create: (_) => productsService),
        ChangeNotifierProvider(create: (_) => session),
        ChangeNotifierProvider(create: (_) => inputValidators),
        ChangeNotifierProvider(create: (_) => mapsApiService),
        ChangeNotifierProvider(create: (_) => categorySelection),
        ChangeNotifierProvider(create: (_) => checkout),
      ],
      child: const CamiloApp(),
    ),
  );
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
  GetIt.I.registerLazySingleton<ProductList>(() => ProductList());
  GetIt.I.registerLazySingleton<ProductCart>(() => ProductCart());
  GetIt.I.registerLazySingleton<ProductsService>(() => ProductsService());
  GetIt.I.registerLazySingleton<Session>(() => Session());
  GetIt.I.registerLazySingleton<InputValidators>(() => InputValidators());
  GetIt.I.registerLazySingleton<AppLogic>(() => AppLogic());
  GetIt.I.registerLazySingleton<MapsService>(() => MapsService());
  GetIt.I.registerLazySingleton<CategorySelection>(() => CategorySelection());
  GetIt.I.registerLazySingleton<Checkout>(() => Checkout());
}

UiConstants get uiConstants => GetIt.I<UiConstants>();
ProductList get products => GetIt.I<ProductList>();
ProductCart get productCart => GetIt.I<ProductCart>();
ProductsService get productsService => GetIt.I<ProductsService>();
Session get session => GetIt.I<Session>();
InputValidators get inputValidators => GetIt.I<InputValidators>();
AppLogic get appLogic => GetIt.I<AppLogic>();
MapsService get mapsApiService => GetIt.I<MapsService>();
CategorySelection get categorySelection => GetIt.I<CategorySelection>();
Checkout get checkout => GetIt.I<Checkout>();
