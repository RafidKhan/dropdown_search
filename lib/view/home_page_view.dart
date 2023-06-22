import 'package:flutter/material.dart';
import 'package:flutter_dropdown_search/view/user_multiple_search.dart';
import 'package:flutter_dropdown_search/view/user_single_search.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: const [
          UserSingleSearch(),
          SizedBox(
            height: 40,
          ),
          UserMultipleSearch(),
        ],
      ),
    );
  }
}
