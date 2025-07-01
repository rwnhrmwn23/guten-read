import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gutenread/shared/constants/text_constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../shared/constants/style_constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/preferences.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 2;
              });
            },
            children: [
              OnboardPage(
                image: imageOnBoarding1,
                title: onboardTitleOne,
                description: onboardDescriptionOne,
              ),
              OnboardPage(
                image: imageOnBoarding2,
                title: onboardTitleTwo,
                description: onboardDescriptionTwo,
              ),
              OnboardPage(
                image: imageOnBoarding3,
                title: onboardTitleThree,
                description: onboardDescriptionThree,
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: Colors.red,
                  ),
                ),
                const SizedBox(height: 44),
                if (isLastPage)
                  ElevatedButton(
                    onPressed: () async {
                      final onboardingPref = OnboardingPreference();
                      await onboardingPref.setFinished();
                      if (!context.mounted) return;
                      context.go(routingIndex);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      backgroundColor: Colors.redAccent,
                    ),
                    child: Text(getStartedNow, style: buttonTextStyle),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 275),
          const SizedBox(height: 40),
          Text(title, style: titleStyle, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          Text(
            description,
            style: descriptionStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
