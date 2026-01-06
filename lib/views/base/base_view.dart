import 'package:checkplay_mobile/domain/providers/core/page_manager.dart';
import 'package:checkplay_mobile/views/category/category_view.dart';
import 'package:checkplay_mobile/views/home/home_view.dart';
import 'package:checkplay_mobile/views/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView extends StatelessWidget {
  BaseView({super.key});
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(_pageController),
      child: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [HomeView(), CategoryView(), ProfileView()],
          )
        ],
      ),
    );
  }
}
