import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static MaterialPage<void> page() => MaterialPage(
        name: FooderlichPages.onboardingPath,
        key: ValueKey(FooderlichPages.onboardingPath),
        child: const OnboardingScreen(),
      );

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  final _rwColor = const Color.fromRGBO(64, 143, 77, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Getting started'),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context, true),
          child: const Icon(
            Icons.chevron_left,
            size: 35,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _buildPages()),
            _buildIndicator(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildPages() {
    return PageView(
      controller: _controller,
      children: [
        _onboardingPageView(
          icon: Icons.recommend,
          text:
              '''Check out weekly recommended recipes and what your friends are cooking!''',
        ),
        _onboardingPageView(
          icon: Icons.receipt_long,
          text: 'Cook with step by step instructions!',
        ),
        _onboardingPageView(
          icon: Icons.checklist,
          text: 'Keep track of what you need to buy',
        ),
      ],
    );
  }

  Widget _onboardingPageView({
    required IconData icon,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Icon(
                icon,
                size: 180,
                color: _rwColor,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            text,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildIndicator() {
    return SmoothPageIndicator(
      controller: _controller,
      count: 3,
      effect: WormEffect(
        activeDotColor: _rwColor,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
          onPressed: () {
            unawaited(context.read<AppStateManager>().completeOnboarding());
          },
          child: const Text('Skip'),
        ),
      ],
    );
  }
}
