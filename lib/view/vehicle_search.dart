// import 'package:flutter/material.dart';
// import 'package:flutter_dropdown_search/models/vehicle_model.dart';
// import 'package:flutter_dropdown_search/view/data_tile.dart';
// import 'package:flutter_dropdown_search/dropdown_search/dropdown_search.dart';
// import 'package:flutter_dropdown_search/dropdown_search/properties/dropdown_decorator_props.dart';
// import '../dropdown_search/properties/popup_props.dart';
// import '../dropdown_search/properties/text_field_props.dart';
//
// class VehicleSearch extends StatefulWidget {
//   const VehicleSearch({Key? key}) : super(key: key);
//
//   @override
//   State<VehicleSearch> createState() => _VehicleSearchState();
// }
//
// class _VehicleSearchState extends State<VehicleSearch> {
//   String queryText = '';
//
//   VehicleModel? selectedVehicle;
//
//   selectVehicle(VehicleModel model) {
//     selectedVehicle = model;
//
//     setState(() {});
//   }
//
//   setSearchQuery(String value) {
//     queryText = value;
//   }
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
//           final VehicleModel model = data;
//
//           final String query = queryText.toLowerCase().trim();
//           final String name = model.name.toLowerCase().trim();
//           final String id = model.id.toString().toLowerCase().trim();
//
//           if (query.isEmpty) {
//             return DataTile(
//               name: model.name,
//               id: model.id.toString(),
//               color: index.isOdd ? Colors.amber : Colors.blue,
//             );
//           } else if (query == name ||
//               query == id ||
//               query.contains(name) ||
//               name.contains(query) ||
//               query.contains(id) ||
//               id.contains(query)) {
//             return DataTile(
//               name: model.name,
//               id: model.id.toString(),
//               color: index.isOdd ? Colors.amber : Colors.blue,
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
//       items: vehicleList,
//       dropdownDecoratorProps: const DropDownDecoratorProps(
//         dropdownSearchDecoration: InputDecoration(
//           border: InputBorder.none,
//           filled: true,
//           fillColor: Colors.white,
//           labelText: "Vehicles",
//           labelStyle: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w400,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       selectedItem:
//           selectedVehicle == null ? null : selectedVehicle!.name.toString(),
//       onSelect: (value) {
//         final VehicleModel vehicleModel = value;
//         selectVehicle(vehicleModel);
//       },
//     );
//   }
// }
