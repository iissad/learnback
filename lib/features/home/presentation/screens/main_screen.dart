import 'package:flutter/material.dart';
import 'package:learnback/app/theme/app_colors.dart';
import 'package:learnback/features/home/presentation/screens/home_screen.dart';
import 'package:learnback/features/home/presentation/widgets/custom_bottom_nav.dart';
import 'package:learnback/features/matching/presentation/screens/matching_screen.dart';
import 'package:learnback/features/profile/presentation/screens/profile_screen.dart';
import 'package:learnback/features/roadmap/presentation/screens/roadmap_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const RoadmapScreen(),
    const MatchingScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBgPrimary,
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
