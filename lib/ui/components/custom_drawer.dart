import '../../common_libs.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<Session>(builder: (context, session, child) {
        const String visitorName = 'visitante';
        const String loginLinkText = 'Entrar';
        const String registerLinkText = 'Cadastrar';
        const String userOrdersLinkText = 'Meus pedidos';
        const String userDataLinkText = 'Meus dados';
        const String logoutLinkText = 'Sair';
        const String logoutMessage = 'Você saiu. Continue navegando.';

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
                    'Olá, ${session.userData?.displayName ?? visitorName}.',
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
                        title: const Text(loginLinkText),
                        onTap: () {
                          Scaffold.of(context).closeDrawer();
                          appRouter.push(ScreenPaths.login);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.person_add),
                        title: const Text(registerLinkText),
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
                        title: const Text(userOrdersLinkText),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text(userDataLinkText),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.exit_to_app),
                        title: const Text(logoutLinkText),
                        onTap: () {
                          Scaffold.of(context).closeDrawer();
                          session.logout();
                          ScaffoldMessenger.of(context).clearSnackBars();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(logoutMessage),
                            ),
                          );
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
