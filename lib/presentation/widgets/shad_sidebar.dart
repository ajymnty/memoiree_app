import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoiree/presentation/widgets/shad_text.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShadSidebar extends StatelessWidget {
  const ShadSidebar({super.key});

  Widget _buildNavigationButton(String route, String text) {
    final isCurrentRoute = Get.currentRoute == route;
    return SizedBox(
      width: Get.width,
      child: ShadButton.outline(
        onPressed: () {
          if (isCurrentRoute) return;
          Get.offAndToNamed(route);
        },
        backgroundColor: isCurrentRoute ? Colors.black : Colors.white,
        child: ShadText(
          text: text,
          color: !isCurrentRoute ? Colors.black : Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showShadSheet(
          side: ShadSheetSide.right,
          context: Get.context!,
          builder: (_) {
            return ShadSheet(
              child: SizedBox(
                width: Get.width * 0.55,
                child: SafeArea(
                  child: Column(
                    children: [
                      _buildNavigationButton('/flashcards', 'Flash Cards'),

                      _buildNavigationButton('/flash-card-groups', 'Groups'),
                      _buildNavigationButton(
                        '/flash-card-categories',
                        'Categories',
                      ),
                      //_buildNavigationButton('/quiz-mode', 'Quiz Mode'),
                      //_buildNavigationButton('/schedule', 'Schedule'),
                      _buildNavigationButton('/calendar', 'Calendar'),
                      _buildNavigationButton('/diary', 'Diary'),
                      _buildNavigationButton('/support', 'Support'),
                      _buildNavigationButton('/about', 'About'),
                      SizedBox(
                        width: Get.width,
                        child: ShadButton.outline(
                          onPressed: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.remove('user');
                            Get.offAllNamed('/auth');
                          },
                          backgroundColor: Colors.redAccent[200],
                          child: const ShadText(
                            text: 'Logout',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      icon: const Icon(Icons.menu_rounded, color: Colors.black),
    );
  }
}
