import 'package:ciscohacks/pages/tree.dart';
import 'package:flutter/material.dart';

import '../pages/loginpage.dart';
import 'auth.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Tree();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
