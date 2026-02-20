import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/views/home/widgets/home_body.dart';
import 'package:frontend_hackathon_mobile/views/home/widgets/navigation_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
        title: Image.asset("assets/logos/logo_desktop.png", height: 40),
      ),
      body: HomeBodyWidget(),
      bottomNavigationBar: NavigationBarWidget(),
    );
  }
}
