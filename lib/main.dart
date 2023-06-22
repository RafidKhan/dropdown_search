import 'package:flutter/material.dart';
import 'package:flutter_dropdown_search/view/home_page_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'dropdownSearch Demo',
      debugShowCheckedModeBanner: false,
      home: HomePageView(),
    );
  }
}