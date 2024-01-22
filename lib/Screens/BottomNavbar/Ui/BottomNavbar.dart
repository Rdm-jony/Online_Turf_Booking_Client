import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:playspot_client/Screens/Admin%20panel/Ui/AdminPanel.dart';
import 'package:playspot_client/Screens/BottomNavbar/Repo/NavbarRepo.dart';
import 'package:playspot_client/Screens/Home/Ui/HomeScreen.dart';
import 'package:playspot_client/Screens/MybookingScreen/Ui/MybookingScreen.dart';
import 'package:playspot_client/Screens/ProfileScreen/Ui/ProfileScreen.dart';
import 'package:playspot_client/Screens/SpotsScreen/Ui/SpotsScreen.dart';
import 'package:playspot_client/Screens/TurfOwner/Ui/TurfOwnerDashboard.dart';

class BottomNavbar extends StatefulWidget {
  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  var userRole;
  @override
  void initState() {
    userRoleFuction();

    // TODO: implement initState
    super.initState();
  }

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    if (userRole == "turfOwner") {
      return [
        HomeScreen(),
        SpotsScreen(),
        MybookingScreen(),
        ProfileScreen(),
        TurfOwnerDashboard()
      ];
    }
    if (userRole == "admin") {
      return [
        HomeScreen(),
        SpotsScreen(),
        MybookingScreen(),
        ProfileScreen(),
        AdminDashboard()
      ];
    }
    return [
      HomeScreen(),
      SpotsScreen(),
      MybookingScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    if (userRole == "turfOwner") {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.home),
          title: ("Home"),
          activeColorPrimary: CupertinoColors.activeGreen,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.sportscourt),
          title: ("Spots"),
          activeColorPrimary: CupertinoColors.activeGreen,
          inactiveColorPrimary: Color.fromRGBO(142, 142, 147, 1),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.bookmark),
          title: ("My Booking"),
          activeColorPrimary: CupertinoColors.activeGreen,
          inactiveColorPrimary: Color.fromRGBO(142, 142, 147, 1),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.person),
          title: ("Profile"),
          activeColorPrimary: CupertinoColors.activeGreen,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.list_dash),
          title: ("Turf Owner"),
          activeColorPrimary: CupertinoColors.activeGreen,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    }
    if (userRole == "admin") {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.home),
          title: ("Home"),
          activeColorPrimary: CupertinoColors.activeGreen,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.sportscourt),
          title: ("Spots"),
          activeColorPrimary: CupertinoColors.activeGreen,
          inactiveColorPrimary: Color.fromRGBO(142, 142, 147, 1),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.bookmark),
          title: ("My Booking"),
          activeColorPrimary: CupertinoColors.activeGreen,
          inactiveColorPrimary: Color.fromRGBO(142, 142, 147, 1),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.person),
          title: ("Profile"),
          activeColorPrimary: CupertinoColors.activeGreen,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.list_dash),
          title: ("Admin panel"),
          activeColorPrimary: CupertinoColors.activeGreen,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    }
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeGreen,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.sportscourt),
        title: ("Spots"),
        activeColorPrimary: CupertinoColors.activeGreen,
        inactiveColorPrimary: Color.fromRGBO(142, 142, 147, 1),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.bookmark),
        title: ("My Booking"),
        activeColorPrimary: CupertinoColors.activeGreen,
        inactiveColorPrimary: Color.fromRGBO(142, 142, 147, 1),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("Profile"),
        activeColorPrimary: CupertinoColors.activeGreen,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),

      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style2, // Choose the nav bar style with this property.
    );
  }

  void userRoleFuction() async {
    userRole = await NavbarRepo.fatchUserRole();
    setState(() {});
  }
}
