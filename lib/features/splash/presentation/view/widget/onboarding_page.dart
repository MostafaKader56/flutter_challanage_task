import 'package:flutter/material.dart';

import '../../../../../core/utils/size_config.dart';
import '../../../data/models/onboarding_model.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.page,
    required this.isLandscape,
  });
  final OnboardingModel page;
  final bool isLandscape;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = isLandscape
        ? SizeConfig.screenWidth
        : SizeConfig.screenHeight;
    final double screenWidth = isLandscape
        ? SizeConfig.screenHeight
        : SizeConfig.screenWidth;
    if (isLandscape) {
      // Landscape layout - side by side
      return Padding(
        padding: EdgeInsets.all(SizeConfig.defaultSize * 1.5),
        child: Row(
          children: [
            // Image section
            Expanded(
              flex: 2,
              child: Center(
                child: Image.asset(
                  page.imagePath,
                  height: screenHeight * 0.6, // Reduced height for landscape
                  width: screenWidth * 0.4,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            SizedBox(width: SizeConfig.defaultSize * 2),

            // Text section
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    page.getTitle(context),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: isLandscape
                          ? 20
                          : null, // Slightly smaller in landscape
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: SizeConfig.defaultSize * 1.5),
                  Text(
                    page.getDescription(context),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: isLandscape
                          ? 14
                          : null, // Slightly smaller in landscape
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      // Portrait layout - stacked vertically
      return Padding(
        padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 3,
              child: Image.asset(
                page.imagePath,
                height: screenHeight * 0.30,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize * 4),
            Flexible(
              flex: 2,
              child: Column(
                children: [
                  Text(
                    page.getTitle(context),
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.defaultSize * 2),
                  Text(
                    page.getDescription(context),
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
