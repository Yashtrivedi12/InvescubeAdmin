// ignore: file_names
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invescube_admin/Widget/Drawer.dart';
import 'package:invescube_admin/main.dart';
import 'package:invescube_admin/screens/Invesment/invesmentScreen.dart';

import 'package:invescube_admin/screens/Trading/tradingScreen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime? _lastClicked;
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        final now1 = DateTime(1900);
        print(now1);
        bool allowPop = false;
        if (_lastClicked == null ||
            now.difference(_lastClicked!) > const Duration(seconds: 1)) {
          _lastClicked = now;

          Fluttertoast.showToast(
              msg: 'Double Click To Back Button Exit',
              backgroundColor: Colors.black,
              gravity: ToastGravity.SNACKBAR);
        } else {
          allowPop = true;
        }
        return Future<bool>.value(allowPop);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.white,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TradingTableView()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage(
                            'assets/trading.jpg',
                          ),
                          fit: BoxFit.cover),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF536976), Color(0xFF292e49)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Icon(Icons.trending_up,
                                  color: Colors.white, size: 24.0),
                              SizedBox(width: 8.0),
                              Text(
                                'Trading',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InvestmentTableView()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          15.0), // Apply border radius here
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Image
                          Image.asset(
                            'assets/investment.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          // Overlay
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  15.0), // Apply border radius here
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.5)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0.0, 0.7],
                              ),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.pie_chart,
                                          color: Colors.white, size: 24.0),
                                      SizedBox(width: 8.0),
                                      Text(
                                        'Investment',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: CustomDrawer(
            currentRoute:
                ModalRoute.of(context)!.settings.name ?? '/dashboard'),
      ),
    );
  }
}
