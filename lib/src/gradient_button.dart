import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A reusable gradient button widget with glossy highlight effects.
///
/// Designed to provide a premium-looking button UI with:
/// - Gradient background
/// - Soft light reflections
/// - Responsive width support using ScreenUtil
/// - Customizable text, size, and font
///
/// Suitable for authentication buttons, CTAs, and modern UI designs.
class GradientButton extends StatelessWidget {
  /// show circular progress bar color for loading
  final bool isLoading;

  final Color loadingIndicatorColor;

  /// The label text displayed on the button
  final String text;

  /// Add the TextStyle of the button text
  final TextStyle? textStyle;

  /// Callback executed when the button is tapped
  final VoidCallback onTap;

  /// Height of the button (default: 45)
  /// Controls overall size and border radius
  final double height;

  /// Width of the button (default: full width)
  /// Can be constrained externally if needed
  final double width;

  /// Box Shadow for the button
  final bool showBoxShadow;

  /// Optional custom font size for button text
  final double? fontSize;

  /// Color Property support added for changing button color
  final Color color;

  const GradientButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height = 45, // Default button height
    this.width = double.infinity,
    this.fontSize,
    this.isLoading = false,
    this.textStyle,
    this.color = Colors.black,
    this.loadingIndicatorColor = Colors.white,
    this.showBoxShadow = false, // Default hide box shadow
  });

  @override
  Widget build(BuildContext context) {
    Color buttonColor = color;
    return GestureDetector(
      /// Handles tap interaction for the button
      onTap: onTap,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          /// Prevents the button from becoming too wide on large screens
          /// Uses ScreenUtil to maintain responsiveness
          maxWidth: 400.w,
        ),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            /// Creates pill-shaped rounded button
            borderRadius: BorderRadius.circular(height / 2),

            // /// Shadow for elevation and depth effect
            boxShadow: !showBoxShadow
                ? []
                : [
                    BoxShadow(
                      color: buttonColor.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
          ),
          child: Stack(
            children: [
              /// Base dark gradient background layer
              /// Provides the primary button color tone
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height / 2),
                  gradient:  LinearGradient(
                    begin: Alignment.topCenter,
                    end: const Alignment(0, 9),
                    stops:const [0.0, 0.05],
                    colors: [buttonColor.withValues(alpha: 2.8), buttonColor],
                  ),
                ),
              ),

              /// Top-left glossy highlight layer
              /// Adds premium reflective lighting effect
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height / 2),
                  gradient: LinearGradient(
                    begin: Alignment(-1, -1),
                    end: Alignment(0, 1),
                    stops: [-1, 0.2],
                    colors: [
                      Colors.white.withValues(alpha: 0.45),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              /// Top-center soft glow highlight
              /// Enhances depth and shine in the middle area
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height / 2),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.white.withValues(alpha: 0.22),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              /// Top-right reflective highlight
              /// Balances lighting across the button surface
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height / 2),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomCenter,
                    stops: [-1, 0.2],
                    colors: [
                      Colors.white.withValues(alpha: 0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              /// Centered button label text
              /// Automatically scales based on button height if fontSize is not provided
              Center(
                child: isLoading
                    ? SizedBox(
                        height: 15.h,
                        width: 15.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                          color: loadingIndicatorColor,
                        ),
                      )
                    : Text(
                        text,
                        style: textStyle ??
                            TextStyle(
                              color: Colors.white,
                              fontSize: fontSize ?? height * 0.30,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.4,
                            ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
