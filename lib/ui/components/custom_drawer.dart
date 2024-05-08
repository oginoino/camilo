import '../../common_libs.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<Session>(builder: (context, session, child) {
        return ListView(
          padding: EdgeInsets.all(uiConstants.paddingMedium),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    radius: 40,
                    child: Icon(
                      Icons.person_rounded,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Olá, ${session.userData?.displayName ?? 'visitante'}.',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                  ),
                ],
              ),
            ),
            !session.isAuthenticated
                ? Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.login),
                        title: const Text('Entrar'),
                        onTap: () {
                          Scaffold.of(context).closeDrawer();
                          appRouter.push(ScreenPaths.login);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.person_add),
                        title: const Text('Cadastrar'),
                        onTap: () {
                          Scaffold.of(context).closeDrawer();
                          appRouter.push(ScreenPaths.register);
                        },
                      ),
                    ],
                  )
                : Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.shopping_cart),
                        title: const Text('Meus pedidos'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text('Meus dados'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.exit_to_app),
                        title: const Text('Sair'),
                        onTap: () {
                          Scaffold.of(context).closeDrawer();
                          session.logout();
                        },
                      ),
                    ],
                  ),
          ],
        );
      }),
    );
  }
}
