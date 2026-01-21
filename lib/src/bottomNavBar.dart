import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_kanpur_ui_kit/core/utils/assets_path.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final double? horizontalPadding;
  final double? verticalPadding;

  const BottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.verticalPadding,
    this.horizontalPadding,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 20.0.w,
        vertical: verticalPadding ?? 20.0.h,
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(40.r),
        child: Container(
          height: 65.h,
          color: const Color(0xFF1F1F1F),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _navItem(AssetsPath.home, 0),
              _navItem(AssetsPath.search, 1),
              _navItem(AssetsPath.create, 2),
              _navItem(AssetsPath.trending, 3),
              _navItem(AssetsPath.profile, 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(String icon, int index) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        height: 40.h,
        padding: isSelected
            ? EdgeInsets.symmetric(horizontal: 15.sp)
            : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF363636) : Colors.transparent,
          borderRadius: BorderRadius.circular(40.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              package: 'flutter_kanpur_ui_kit',
              height: 0.023.sh,
              colorFilter: ColorFilter.mode(
                isSelected ? const Color(0xffFFFFFF) : const Color(0xffA8A7A8),
                BlendMode.srcIn,
              ),
            ),

            if (isSelected && index != 2) ...[
              10.horizontalSpace,
              Text(
                _labelForIndex(index),
                style: GoogleFonts.poppins(
                  color:  const Color(0XFFFFFFFF),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _labelForIndex(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Search';
      case 2:
        return 'Create';
      case 3:
        return 'Trending';
      case 4:
        return 'Profile';
      default:
        return '';
    }
  }
}
