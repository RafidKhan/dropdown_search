import 'package:flutter/material.dart';
import 'package:flutter_dropdown_search/view/alphabet_search.dart';
import 'package:flutter_dropdown_search/view/user_search.dart';
import 'package:flutter_dropdown_search/view/vehicle_search.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: const [
          UserSearch(),
          // SizedBox(
          //   height: 50,
          // ),
          // VehicleSearch(),
          // SizedBox(
          //   height: 50,
          // ),
          // AlphabetSearch(),
        ],
      ),
    );
  }
}
