import 'package:flutter/material.dart';
import 'package:flutter_dropdown_search/dropdown_search/properties/list_view_props.dart';
import 'package:flutter_dropdown_search/dropdown_search/properties/text_field_props.dart';

import '../dropdown_search.dart';
import 'menu_props.dart';

class PopupProps {
  final DropdownSearchPopupItemBuilder itemBuilder;

  final TextFieldProps searchFieldProps;

  final ListViewProps listViewProps;

  final Duration searchDelay;

  final VoidCallback? onDismissed;

  final EmptyBuilder? emptyBuilder;

  final MenuProps menuProps;

  final FlexFit fit;

  final BoxConstraints constraints;

  final DropdownSearchPopupItemBuilder? selectionWidget;

  final TextDirection textDirection;

  const PopupProps({
    this.fit = FlexFit.tight,
    this.menuProps = const MenuProps(),
    this.searchFieldProps = const TextFieldProps(),
    this.listViewProps = const ListViewProps(),
    this.searchDelay = const Duration(seconds: 1),
    this.onDismissed,
    this.emptyBuilder,
    required this.itemBuilder,
    this.constraints = const BoxConstraints(maxHeight: 350),
    this.textDirection = TextDirection.ltr,
    this.selectionWidget,
  });
}
