import 'package:flutter/material.dart';
import 'package:ulp_inmo/src/widgets/navigation_drawer_widget.dart';
import 'package:ulp_inmo/src/widgets/stain_bg.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;
  final Widget? title;
  final int navIndex;
  final List<Widget>? navActions;
  const MainScaffold({Key? key, required this.child, this.navIndex = 0, this.navActions, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavigationDrawerWidget(navIndex),
      appBar: AppBar(
        centerTitle: true,
        title: title,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.secondary, size: 30),
        actions: navActions,
      ),
      body: Stack(
        children: <Widget>[
          StainBg(),
          child,
        ],
      ),
    );
  }
}
