import 'package:flutter/material.dart';
import 'package:invescube_admin/screens/Invesment/invesmentScreen.dart';


import 'package:invescube_admin/screens/Trading/tradingScreen.dart';
import 'package:invescube_admin/screens/dashboardScreen.dart';

class CustomDrawer extends StatefulWidget {
  final String currentRoute;

  const CustomDrawer({super.key, required this.currentRoute});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  void _navigateTo(BuildContext context, String route, Widget screen) {
    if (ModalRoute.of(context)?.settings.name != route) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => screen, settings: RouteSettings(name: route)),
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF4e4376),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Menu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.dashboard,
              text: 'Dashboard',
              route: '/dashboard',
              screen: DashboardScreen(),
              isSelected: widget.currentRoute == '/dashboard',
            ),
            _buildDrawerItem(
              icon: Icons.trending_up,
              text: 'Trading',
              route: '/trading',
              screen: TradingTableView(),
              isSelected: widget.currentRoute == '/trading',
            ),
            _buildDrawerItem(
              icon: Icons.pie_chart,
              text: 'Investment',
              route: '/investment',
              screen: InvestmentTableView(),
              isSelected: widget.currentRoute == '/investment',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required String route,
    required Widget screen,
    required bool isSelected,
  }) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.blue : Colors.black),
      title: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.blue : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: isSelected ? Colors.blue : Colors.black,
      ),
      tileColor: isSelected ? Colors.blue.shade50 : Colors.transparent,
      onTap: () => _navigateTo(context, route, screen),
    );
  }
}
