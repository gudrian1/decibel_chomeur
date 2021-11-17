import 'package:chomeurs/Statistique/page_statistique.dart';
import 'package:flutter/material.dart';

import '../Enregistrement/enregistrements.dart';

//import 'package:bottom_navigation_bar/home_screen.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  // ignore: prefer_final_fields
  List<Widget> _widgetOptions = <Widget>[
    PageStatistique(),
    const Text('Save Screen'),
    const Text('Setting Screen'),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int? _currentPage;

  @override
  void initState() {
    _currentPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: AnimatedBottomNav(
          currentIndex: _currentPage,
          onChange: (index) {
            setState(() {
              _currentPage = index;
            });
          }),
    );
  }

  getPage(int? page) {
    switch (page) {
      case 0:
        return Center(
            child: Container(
          child: Text("Blabla"),
        ));
      case 1:
        return Center(
            child: Container(
          child: Text("Enregistrements"),
        ));
      case 2:
        return Center(
            child: Container(
          child: Text("Profil"),
        ));
    }
  }
}

class AnimatedBottomNav extends StatelessWidget {
  double? size;
  final int? currentIndex;
  final Function(int)? onChange;
  AnimatedBottomNav({Key? key, this.currentIndex, this.onChange})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color(0xFF9EA2A6);
    return Container(
      height: kToolbarHeight,
      decoration: const BoxDecoration(
        color: Color(0xFF9EA2A6),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              child: IconButton(
                iconSize: 48,
                icon: Image.asset("assets/Icones/coolicon3.png"),
                onPressed: () {},
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              child: IconButton(
                iconSize: 48,
                icon: Image.asset("assets/Icones/Save_fill.png"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Enregistrements()),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              child: IconButton(
                iconSize: 48,
                icon: Image.asset("assets/Icones/parametre.png"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Enregistrements()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  Color primaryColor = Color(0xFFC2C4B9);
  final bool isActive;
  final IconData? icon;
  final Color? activeColor;
  final Color? inactiveColor;
  final String? title;
  BottomNavItem(
      {Key? key,
      this.isActive = false,
      this.icon,
      this.activeColor,
      this.inactiveColor,
      this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      duration: Duration(milliseconds: 500),
      reverseDuration: Duration(milliseconds: 200),
      child: isActive
          ? Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: activeColor ?? Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Container(
                    width: 9.0,
                    height: .0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: activeColor ?? Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            )
          : Icon(
              icon,
              color: inactiveColor ?? primaryColor,
            ),
    );
  }
}
