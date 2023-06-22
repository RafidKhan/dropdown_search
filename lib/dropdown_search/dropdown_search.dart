import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dropdown_search/dropdown_search/widgets/popup_menu.dart';

import 'properties/popup_props.dart';
import 'widgets/selection_widget.dart';

typedef Widget DropdownSearchPopupItemBuilder(
  BuildContext context,
  dynamic item,
  int index,
);

typedef Widget EmptyBuilder(BuildContext context, String searchEntry);
typedef Future<bool?> BeforePopupOpening(selectedItem);

class DropdownSearch extends StatefulWidget {
  final String title;

  final List items;

  final String? selectedItem;

  final List selectedItems;

  final Function(dynamic) onSelect;

  final ValueChanged<List<dynamic>>? onChangedMultiSelection;

  final bool enabled;

  final PopupProps popupProps;

  final Function(String) onSearchTextChange;

  final BeforePopupOpening? onBeforePopupOpening;

  final BoxDecoration? containerDecoration;

  final Function() clearTextAction;

  final Widget? selectedItemCustomWidget;

  final Function()? onClearData;

  final EdgeInsets? padding;

  final EdgeInsets? margin;

  final Color? color;

  final Widget? dropdownButton;

  const DropdownSearch({
    Key? key,
    required this.onSelect,
    required this.title,
    this.items = const [],
    required this.selectedItem,
    this.enabled = true,
    this.onBeforePopupOpening,
    this.containerDecoration,
    required this.popupProps,
    required this.onSearchTextChange,
    required this.clearTextAction,
    this.selectedItemCustomWidget,
    this.onClearData,
    this.padding,
    this.margin,
    this.color,
    this.dropdownButton,
    this.onChangedMultiSelection,
    this.selectedItems = const [],
  }) : super(key: key);

  @override
  DropdownSearchState createState() => DropdownSearchState();
}

class DropdownSearchState extends State<DropdownSearch> {
  final ValueNotifier<bool> _isFocused = ValueNotifier(false);
  final _popupStateKey = GlobalKey<SelectionWidgetState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectSearchMode(),
      child: widget.selectedItemCustomWidget ??
          Container(
            padding: widget.padding ??
                const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
            margin: widget.margin ?? EdgeInsets.zero,
            decoration: BoxDecoration(
              color: widget.color ?? Colors.grey[100],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title),
                    if (widget.selectedItem != null) Text(widget.selectedItem!),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.onClearData != null)
                      InkWell(
                          onTap: () {
                            widget.onClearData!();
                          },
                          child: const Icon(
                            Icons.close,
                            size: 20,
                          )),
                    widget.dropdownButton ??
                        const Icon(
                          Icons.arrow_drop_down,
                        ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  RelativeRect _position(RenderBox popupButtonObject, RenderBox overlay) {
    return RelativeRect.fromSize(
      Rect.fromPoints(
        popupButtonObject.localToGlobal(
            popupButtonObject.size.bottomLeft(Offset.zero),
            ancestor: overlay),
        popupButtonObject.localToGlobal(
            popupButtonObject.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Size(overlay.size.width, overlay.size.height),
    );
  }

  ///openMenu
  Future _openMenu() {
    final popupButtonObject = context.findRenderObject() as RenderBox;
    var overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    return showCustomMenu(
      menuModeProps: widget.popupProps.menuProps,
      context: context,
      position: (_position)(
        popupButtonObject,
        overlay,
      ),
      child: _popupWidgetInstance(),
    );
  }

  Widget _popupWidgetInstance() {
    return SelectionWidget(
      key: _popupStateKey,
      popupProps: widget.popupProps,
      items: widget.items,
      onSelect: widget.onSelect,
      onSearchTextChange: widget.onSearchTextChange,
      containerDecoration: widget.containerDecoration,
      clearTextAction: widget.clearTextAction,
    );
  }

  void _handleFocus(bool isFocused) {
    if (isFocused && !_isFocused.value) {
      FocusScope.of(context).unfocus();
      _isFocused.value = true;
    } else if (!isFocused && _isFocused.value) {
      _isFocused.value = false;
    }
  }

  Future<void> _selectSearchMode() async {
    if (widget.onBeforePopupOpening != null) {
      if (await widget.onBeforePopupOpening!(widget.selectedItem) == false) {
        return;
      }
    }

    _handleFocus(true);
    await _openMenu();
    widget.popupProps.onDismissed?.call();
    _handleFocus(false);
  }
}
