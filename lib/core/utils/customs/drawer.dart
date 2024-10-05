import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/customs/app_logo.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    super.key,
  });

  @override
  State<AppDrawer> createState() => AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> {
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        children: [
          const AppLogo(),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                // drawerItem(context, 1, 'Dashboard', Icons.dashboard),
                // const SizedBox(
                //   height: 40,
                // ),
                drawerItem(context, 1, 'Leagues', Icons.event),
                const SizedBox(
                  height: 40,
                ),
                // drawerItem(context, 3, 'Cups', Icons.assignment),
                // const SizedBox(
                //   height: 40,
                // ),
                // drawerItem(context, 4, 'Players', Icons.person),
                // const SizedBox(
                //   height: 40,
                // ),
                // drawerItem(context, 5, 'Trophies', Icons.mail),
              ],
            ),
          )
        ],
      ),
    );
  }

  _itemClick(BuildContext context, int index) {
    switch (index) {
      // case 1:
      //   GoRouter.of(context).go(AppRouter.home);
      //   break;
      case 1:
        GoRouter.of(context).go(AppRouter.leagues);
        break;
      // case 3:
      //   // GoRouter.of(context).go(AppRouter.activities);
      //   break;
      // case 4:
      //   GoRouter.of(context).go(AppRouter.users);
      //   break;
      case 5:
        // GoRouter.of(context).go(AppRouter.messages);
        break;
    }
    setState(() {
      currentIndex = index;
    });
  }

  Widget drawerItem(
      BuildContext context, int index, String title, IconData icon) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        _itemClick(context, index);
      },
      child: Row(
        children: [
          Icon(
            icon,
            size: 25,
            color:
                currentIndex == index ? AppColors.kPrimaryColor : Colors.grey,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: Styles.normal16.copyWith(
              color:
                  currentIndex == index ? AppColors.kPrimaryColor : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
