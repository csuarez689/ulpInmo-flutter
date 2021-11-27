import 'package:flutter/material.dart';
import 'package:ulp_inmo/src/widgets/navigation_drawer_widget.dart';
import 'package:ulp_inmo/src/widgets/stain_bg.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;
  final Widget? title;
  final int navIndex;
  final List<Widget>? navActions;
  final Widget? floatingActionButton;
  const MainScaffold({Key? key, required this.body, this.navIndex = 0, this.navActions, this.title, this.floatingActionButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavigationDrawerWidget(navIndex),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) => Container(
            padding: const EdgeInsets.only(left: 10),
            child: MaterialButton(
              color: Theme.of(context).colorScheme.secondary,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(0),
              child: const Icon(Icons.menu, size: 28, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        centerTitle: true,
        title: title,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.secondary, size: 30),
        actions: navActions,
      ),
      body: Stack(children: [
        const StainBg(),
        SafeArea(
          child: body,
        ),
      ]),
      floatingActionButton: floatingActionButton,
    );
  }
}
