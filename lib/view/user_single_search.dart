import 'package:flutter/material.dart';
import 'package:flutter_dropdown_search/dropdown_search/dropdown_search.dart';
import 'package:flutter_dropdown_search/dropdown_search/properties/text_field_props.dart';
import 'package:flutter_dropdown_search/models/user_model.dart';
import 'package:flutter_dropdown_search/view/data_tile.dart';

import '../dropdown_search/properties/popup_props.dart';

class UserSingleSearch extends StatefulWidget {
  const UserSingleSearch({Key? key}) : super(key: key);

  @override
  State<UserSingleSearch> createState() => _UserSingleSearchState();
}

class _UserSingleSearchState extends State<UserSingleSearch> {
  String queryText = '';

  UserModel? selectedUser;

  selectUser(UserModel? model) {
    selectedUser = model;

    setState(() {});
  }

  setSearchQuery(String value) {
    queryText = value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch(
      title: "User Single Search",
      isMultiSelect: false,
      onBeforePopupOpening: (item) async {
        setSearchQuery("");
        return true;
      },
      clearTextAction: () {
        setSearchQuery("");
      },
      onClearData: selectedUser == null
          ? null
          : () {
              selectUser(null);
            },
      popupProps: PopupProps(
        itemBuilder: (context, data, index) {
          final UserModel model = data;

          final String query = queryText.toLowerCase().trim();
          final String name = model.name.toLowerCase().trim();
          final String id = model.id.toLowerCase().trim();

          if (query.isEmpty) {
            return DataTile(
              name: model.name,
              id: model.id,
              color: index.isOdd ? Colors.amber : Colors.blue,
            );
          } else if (query == name ||
              query == id ||
              query.contains(name) ||
              name.contains(query) ||
              query.contains(id) ||
              id.contains(query)) {
            return DataTile(
              name: model.name,
              id: model.id,
              color: index.isOdd ? Colors.amber : Colors.blue,
            );
          }

          return const SizedBox();
        },
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(Icons.search),
            hintText: "Search Here",
          ),
        ),
      ),
      onSearchTextChange: (value) {
        setSearchQuery(value);
      },
      items: usersList,
      selectedItem: selectedUser == null ? null : selectedUser!.name.toString(),
      onSelect: (value) {
        final UserModel userModel = value;
        selectUser(userModel);
      },
    );
  }
}
