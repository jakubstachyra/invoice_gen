import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/blocs/invoice_generation/invoice_bloc.dart';
import 'package:invoice_gen/screens/invoice/invoice_generation.dart';
import 'package:invoice_gen/screens/menu/invoices_screen.dart';
import 'package:invoice_gen/screens/menu/reports_screen.dart';
import 'package:invoice_gen/screens/menu/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const InvoicesScreen(),
    const ReportsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Blok umieszczony tutaj jest dostępny dla całego drzewa Scaffold.
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Invoice Gen'),
          toolbarHeight: 30,
        ),
        body: _screens[_currentIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const InvoiceGenerationScreen()),
            );
          },
          tooltip: 'Generate Invoice',
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              label: 'Invoices',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assessment),
              label: 'Reports',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      );
  }
}

