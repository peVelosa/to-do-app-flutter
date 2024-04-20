import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/components/elements/appbar.dart';
import 'package:myapp/components/elements/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: const Scaffold(
        appBar: MyAppBar(),
        body: HomeView(),
      ),
    );
  }
}
