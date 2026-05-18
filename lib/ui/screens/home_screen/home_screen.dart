import 'package:aether_project/core/di/injection.dart';
import 'package:aether_project/services/raid_service.dart';
import 'package:aether_project/ui/screens/home_screen/widgets/home_screen_section1.dart';
import 'package:aether_project/ui/screens/home_screen/widgets/home_screen_section2.dart';
import 'package:aether_project/ui/screens/home_screen/widgets/home_screen_section3.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            const HomeScreenSection1(),
            const SizedBox(height: 24),
            const HomeScreenSection2(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                sl<RaidService>().rapidConcurrencyTest();
              },
              child: const Text('Join Raid 20 test'),
            ),
            const SizedBox(height: 24),

            const HomeScreenSection3(),
          ],
        ),
      ),
    );
  }
}
