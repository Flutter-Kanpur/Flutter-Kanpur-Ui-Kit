import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_kanpur_ui_kit/core/utils/assets_path.dart';
import 'package:google_fonts/google_fonts.dart';

/// A customizable bottom navigation bar widget.
///
/// Displays SVG icons with an animated selected state and optional labels.
/// Designed to be reusable across different applications.
///
/// ## Usage Example
///
/// ```dart
/// class MainNavigationPage extends StatefulWidget {
///   const MainNavigationPage({super.key});
///
///   @override
///   State<MainNavigationPage> createState() => _MainNavigationPageState();
/// }
///
/// class _MainNavigationPageState extends State<MainNavigationPage> {
///   int _currentIndex = 0;
///
///   final List<Widget> _pages = [
///     const HomePage(),
///     const SearchPage(),
///     const CreatePage(),
///     const TrendingPage(),
///     const ProfilePage(),
///   ];
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: IndexedStack(
///         index: _currentIndex,
///         children: _pages,
///       ),
///       bottomNavigationBar: GlassBottomNavbar(
///         currentIndex: _currentIndex,
///         onTap: (index) {
///           setState(() {
///             _currentIndex = index;
///           });
///         },
///       ),
///     );
///   }
/// }
/// ```
///
/// The widget supports 5 navigation items (indices 0-4):
/// - Index 0: Home
/// - Index 1: Search
/// - Index 2: Create
/// - Index 3: Trending
/// - Index 4: Profile
class GlassBottomNavbar extends StatelessWidget {
  /// The currently selected navigation index.
  final int currentIndex;

  /// Callback triggered when a navigation item is tapped.
  final ValueChanged<int> onTap;

  /// Optional horizontal padding for the navigation bar.
  final double? horizontalPadding;

  /// Optional vertical padding for the navigation bar.
  final double? verticalPadding;

  /// Creates a [GlassBottomNavbar] widget.
  ///
  /// The [currentIndex] indicates the active tab,
  /// and [onTap] is called with the selected index.
  const GlassBottomNavbar({
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.r),
          border: Border.all(color: Colors.white,width: 0.5),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xB3FFFFFF), // #FFFFFF at 70% opacity
              Color(0x00F3F8FF), // #F3F8FF at 0% opacity
              Color(0x66FFFFFF), // #FFFFFF at 40% opacity
              Color(0xCCE4EFFF), // #E4EFFF at 80% opacity
            ],
            stops: [0.0, 0.3, 0.6, 1.0],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0x1F000000), // #000000 at 12% opacity
              offset: Offset(0, 28.h),
              blurRadius: 70.r,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40.r),
          child: Container(
            height: 65.h,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xB3FFFFFF), // #FFFFFF at 70% opacity

                  Color(0x66FFFFFF), // #FFFFFF at 40% opacity
                  Color(0x00F3F8FF), // #F3F8FF at 0% opacity
                  Color(0xCCE4EFFF), // #E4EFFF at 80% opacity
                ],
                stops: [0.0, 0.3, 0.6, 1.0],
              ),
            ),
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
      ),
    );
  }

  /// Builds an individual navigation item.
  ///
  /// Displays an SVG icon and optional label when selected.
  Widget _navItem(String icon, int index) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        height: 40.h,
        padding: isSelected
            ? EdgeInsets.symmetric(horizontal: 15.sp, vertical: 8.h)
            : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.9) // Light, opaque background for selected
              : Colors.transparent,
          borderRadius: BorderRadius.circular(40.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              package: 'flutter_kanpur_ui_kit',
              height: 0.023.sh,
              colorFilter: ColorFilter.mode(
                isSelected
                    ? const Color(0xFF4A4A4A) // Dark gray for selected icon
                    : Colors.black.withValues(alpha: 0.9), // White outline for unselected
                BlendMode.srcIn,
              ),
            ),
            if (isSelected && index != 2) ...[
              10.horizontalSpace,
              Text(
                _labelForIndex(index),
                style: GoogleFonts.poppins(
                  color: const Color(0xFF4A4A4A), // Dark gray text
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

  /// Returns the label text for a given navigation index.
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
