// import 'package:flutter/material.dart';
// import 'package:flutter_dropdown_search/dropdown_search/dropdown_search.dart';
// import 'package:flutter_dropdown_search/dropdown_search/properties/dropdown_decorator_props.dart';
//
// import '../dropdown_search/properties/popup_props.dart';
// import '../dropdown_search/properties/text_field_props.dart';
//
// class AlphabetSearch extends StatefulWidget {
//   const AlphabetSearch({Key? key}) : super(key: key);
//
//   @override
//   State<AlphabetSearch> createState() => _AlphabetSearchState();
// }
//
// class _AlphabetSearchState extends State<AlphabetSearch> {
//   String queryText = '';
//
//   String? selectedAlphabet;
//
//   selectAlphabet(String txt) {
//     selectedAlphabet = txt;
//
//     setState(() {});
//   }
//
//   setSearchQuery(String value) {
//     queryText = value;
//   }
//
//   final List<String> alphabets = [
//     "A",
//     "B",
//     "C",
//     "D",
//     "E",
//     "F",
//     "G",
//     "H",
//     "I",
//     "J",
//     "K",
//     "L",
//     "M",
//     "N",
//     "O",
//     "P",
//     "Q",
//     "R",
//     "S",
//     "T",
//     "U",
//     "V",
//     "W",
//     "X",
//     "Y",
//     "Z",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownSearch(
//       onBeforePopupOpening: (item) async {
//         setSearchQuery("");
//         return true;
//       },
//       clearTextAction: () {
//         setSearchQuery("");
//       },
//       popupProps: PopupProps(
//         itemBuilder: (context, data, index) {
//           final String alphabet = data;
//
//           final String query = queryText.toLowerCase().trim();
//           final String alphabetFormatted = alphabet.toLowerCase().trim();
//
//           if (query.isEmpty) {
//             return Center(
//               child: Text(
//                 alphabet,
//                 style: TextStyle(
//                   fontSize: 15,
//                   color: index.isOdd ? Colors.blue : Colors.red,
//                 ),
//               ),
//             );
//           } else if (query == alphabetFormatted ||
//               query.contains(alphabetFormatted) ||
//               alphabetFormatted.contains(query)) {
//             return Center(
//               child: Text(
//                 alphabet,
//                 style: TextStyle(
//                   fontSize: 15,
//                   color: index.isOdd ? Colors.blue : Colors.red,
//                 ),
//               ),
//             );
//           }
//
//           return const SizedBox();
//         },
//         searchFieldProps: TextFieldProps(
//           decoration: InputDecoration(
//             focusedBorder: InputBorder.none,
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(7),
//               borderSide: const BorderSide(color: Colors.grey),
//             ),
//             fillColor: Colors.white,
//             filled: true,
//             prefixIcon: const Icon(Icons.search),
//             hintText: "Search Here",
//           ),
//         ),
//       ),
//       onSearchTextChange: (value) {
//         setSearchQuery(value);
//       },
//       items: alphabets,
//       dropdownDecoratorProps: const DropDownDecoratorProps(
//         dropdownSearchDecoration: InputDecoration(
//           border: InputBorder.none,
//           filled: true,
//           fillColor: Colors.white,
//           labelText: "Alphabets",
//           labelStyle: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w400,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       selectedItem: selectedAlphabet,
//       onSelect: (value) {
//         final String text = value;
//         selectAlphabet(text);
//       },
//     );
//   }
// }
