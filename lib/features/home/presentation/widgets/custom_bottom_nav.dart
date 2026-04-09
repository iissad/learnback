import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnback/app/theme/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 24, left: 24, right: 24),
      decoration: BoxDecoration(color: AppColors.darkBgPrimary),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildItem(0, 'assets/icons/home.svg'),
          _buildItem(1, 'assets/icons/roadmap.svg'),
          _buildItem(2, 'assets/icons/matching.svg'),
          _buildItem(3, 'assets/icons/profile.svg'),
        ],
      ),
    );
  }

  Widget _buildItem(int index, String iconPath) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF003D66).withValues(alpha: 0.4)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: AppColors.blue, width: 1.5)
              : null,
        ),
        child: SvgPicture.asset(
          iconPath,
          colorFilter: ColorFilter.mode(
            isSelected
                ? AppColors.blue
                : AppColors.darkTextSecondary.withValues(alpha: 0.6),
            BlendMode.srcIn,
          ),
          width: 28,
          height: 28,
        ),
      ),
    );
  }
}
