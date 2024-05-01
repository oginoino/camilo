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
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    'Olá, ${session.isAuthenticated ? 'usuário' : 'visitante'}.',
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
                        title: const Text('Entrar'),
                        onTap: () {
                          Scaffold.of(context).closeDrawer();
                          appRouter.push(ScreenPaths.login);
                        },
                      ),
                      ListTile(
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
                        title: const Text('Meus pedidos'),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('Meus dados'),
                        onTap: () {},
                      ),
                      ListTile(
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
