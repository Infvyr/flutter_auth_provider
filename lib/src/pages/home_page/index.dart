import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/src/core/infrastructure/user/user_notifier.dart';
import 'package:flutter_authentication/src/core/presentation/styles/app_styles.dart';
import 'package:flutter_authentication/src/features/index.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final authNotifier = Provider.of<AuthNotifier>(context);
    final userNotifier = Provider.of<UserNotifier>(context);
    userNotifier.readUserData();
    final accountName = '${userNotifier.user.firstName} ${userNotifier.user.lastName}';

    void closeDrawer() {
      if (scaffoldKey.currentState!.isDrawerOpen) {
        scaffoldKey.currentState!.closeDrawer();
      }
    }

    void redirectToSignIn() {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) {
            return const SignInPage();
          },
        ),
        (route) => false,
      );
    }

    void onSignOut() {
      closeDrawer();
      redirectToSignIn();
      authNotifier.signOut();
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome ${userNotifier.user.firstName}!'),
          ],
        ),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: [
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
                  // backgroundImage: NetworkImage(userNotifier.user.avatar),
                  backgroundImage: CachedNetworkImageProvider(
                    userNotifier.user.avatar,
                    cacheKey: userNotifier.user.avatar,
                  ),
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
                title: const Text('Sign Out'),
                titleTextStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
                onTap: () => onSignOut(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
