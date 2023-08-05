import 'package:flutter/material.dart';
import 'package:flutter_authentication/src/core/infrastructure/user/user_notifier.dart';
import 'package:flutter_authentication/src/core/presentation/styles/app_styles.dart';
import 'package:flutter_authentication/src/features/authentication/infrastructure/auth_notifier.dart';
import 'package:flutter_authentication/src/features/authentication/presentation/sign_in_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final authNotifier = Provider.of<AuthNotifier>(context);
    final userNotifier = Provider.of<UserNotifier>(context);
    final isUserAuthenticated = authNotifier.isAuthenticated;
    final accountName = '${userNotifier.user.firstName} ${userNotifier.user.lastName}';

    void closeDrawer() {
      if (scaffoldKey.currentState!.isDrawerOpen) {
        scaffoldKey.currentState!.closeDrawer();
      }
    }

    Future<void> onSignIn() async {
      closeDrawer();
      await Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (_) {
            return const SignInPage();
          },
        ),
      );
    }

    Future<void> onSignOut() async {
      closeDrawer();
      await authNotifier.signOut();
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: Center(
        child: Visibility(
          visible: isUserAuthenticated,
          replacement: const Text('Not Authenticated'),
          child: const Text('Authenticated'),
        ),
      ),
      drawer: SafeArea(
        child: Drawer(
          // backgroundColor: Theme.of(context).colorScheme.surface,
          child: ListView(
            children: [
              if (isUserAuthenticated)
                UserAccountsDrawerHeader(
                  accountName: Text(
                    accountName,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onInverseSurface,
                    ),
                  ),
                  accountEmail: Text(
                    userNotifier.user.email,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onInverseSurface,
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(userNotifier.user.avatar),
                    onBackgroundImageError: (_, __) {},
                  ),
                  decoration: MediaQuery.of(context).platformBrightness == Brightness.light
                      ? BoxDecoration(
                          color: AppStyles.instance.brandColor,
                        )
                      : BoxDecoration(
                          color: AppStyles.instance.textColor,
                        ),
                ),
              ListTile(
                title: isUserAuthenticated ? const Text('Sign Out') : const Text('Sign In'),
                titleTextStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
                onTap: isUserAuthenticated
                    ? () {
                        onSignOut();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) {
                              return const SignInPage();
                            },
                          ),
                          (route) => false,
                        );
                      }
                    : onSignIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
