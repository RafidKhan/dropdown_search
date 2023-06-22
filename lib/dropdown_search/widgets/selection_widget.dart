import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown_search/dropdown_search/properties/popup_props.dart';

class SelectionWidget extends StatefulWidget {
  final List<dynamic> items;
  final Function(dynamic) onSelect;

  final List defaultSelectedItems;
  final PopupProps popupProps;
  final Function(String) onSearchTextChange;
  final BoxDecoration? containerDecoration;
  final Function() clearTextAction;

  const SelectionWidget({
    Key? key,
    required this.popupProps,
    required this.onSearchTextChange,
    this.defaultSelectedItems = const [],
    this.items = const [],
    required this.onSelect,
    //this.asyncItems,
    //this.itemAsString,
    //this.filterFn,
    // this.compareFn,
    this.containerDecoration,
    required this.clearTextAction,
  }) : super(key: key);

  @override
  SelectionWidgetState createState() => SelectionWidgetState();
}

class SelectionWidgetState extends State<SelectionWidget> {
  final StreamController<List> _itemsStream = StreamController.broadcast();
  final ValueNotifier<bool> _loadingNotifier = ValueNotifier(false);
  final List _cachedItems = [];
  final ValueNotifier<List> _selectedItemsNotifier = ValueNotifier([]);
  final ScrollController scrollController = ScrollController();
  final List _currentShowedItems = [];

  TextEditingController searchBoxController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _selectedItemsNotifier.value = widget.defaultSelectedItems;

    Future.delayed(
      Duration.zero,
      () => _manageItemsByFilter(
        searchBoxController.text,
        isFirstLoad: true,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant SelectionWidget oldWidget) {
    if (!listEquals(
        oldWidget.defaultSelectedItems, widget.defaultSelectedItems)) {
      _selectedItemsNotifier.value = widget.defaultSelectedItems;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _itemsStream.close();

    searchBoxController.dispose();

    if (widget.popupProps.listViewProps.controller == null) {
      scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: widget.popupProps.constraints,
      decoration: widget.containerDecoration,
      child: _defaultWidget(),
    );
  }

  Widget _defaultWidget() {
    return ValueListenableBuilder(
        valueListenable: _selectedItemsNotifier,
        builder: (ctx, value, wdgt) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: widget.popupProps.searchFieldProps.padding,
                child: Row(
                  children: [
                    Expanded(child: _searchField()),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        searchBoxController.clear();
                        widget.clearTextAction();
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.close,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: widget.popupProps.fit,
                child: Stack(
                  children: <Widget>[
                    StreamBuilder<List>(
                      stream: _itemsStream.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const SizedBox();
                        } else if (!snapshot.hasData) {
                          return const SizedBox();
                        } else if (snapshot.data!.isEmpty) {
                          return _noDataWidget();
                        }

                        return RawScrollbar(
                          controller:
                              widget.popupProps.listViewProps.controller ??
                                  scrollController,
                          child: ListView.builder(
                            controller:
                                widget.popupProps.listViewProps.controller ??
                                    scrollController,
                            shrinkWrap:
                                widget.popupProps.listViewProps.shrinkWrap,
                            padding: widget.popupProps.listViewProps.padding,
                            scrollDirection:
                                widget.popupProps.listViewProps.scrollDirection,
                            reverse: widget.popupProps.listViewProps.reverse,
                            primary: widget.popupProps.listViewProps.primary,
                            physics: widget.popupProps.listViewProps.physics,
                            itemExtent:
                                widget.popupProps.listViewProps.itemExtent,
                            addAutomaticKeepAlives: widget.popupProps
                                .listViewProps.addAutomaticKeepAlives,
                            addRepaintBoundaries: widget
                                .popupProps.listViewProps.addRepaintBoundaries,
                            addSemanticIndexes: widget
                                .popupProps.listViewProps.addSemanticIndexes,
                            cacheExtent:
                                widget.popupProps.listViewProps.cacheExtent,
                            semanticChildCount: widget
                                .popupProps.listViewProps.semanticChildCount,
                            dragStartBehavior: widget
                                .popupProps.listViewProps.dragStartBehavior,
                            keyboardDismissBehavior: widget.popupProps
                                .listViewProps.keyboardDismissBehavior,
                            restorationId:
                                widget.popupProps.listViewProps.restorationId,
                            clipBehavior:
                                widget.popupProps.listViewProps.clipBehavior,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var item = snapshot.data![index];

                              return _itemWidgetSingleSelection(
                                item: item,
                                index: index,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  ///close popup
  void closePopup() => Navigator.pop(context);

  Widget _noDataWidget() {
    if (widget.popupProps.emptyBuilder != null) {
      return widget.popupProps.emptyBuilder!(
        context,
        searchBoxController.text,
      );
    } else {
      return Container(
        height: 70,
        alignment: Alignment.center,
        child: const Text("No data found"),
      );
    }
  }

  Future<void> _manageItemsByFilter(
    String filter, {
    bool isFirstLoad = false,
  }) async {
    _loadingNotifier.value = true;

    List applyFilter(String filter) {
      return _cachedItems.where((i) {
        if (i.toString().toLowerCase().contains(filter.toLowerCase())) {
          return true;
        }
        return false;
      }).toList();
    }

    if (isFirstLoad) {
      _cachedItems.addAll(widget.items);
    }
    if (isFirstLoad) {
      try {
        _cachedItems.clear();
        _cachedItems.addAll(widget.items);
        _addDataToStream(applyFilter(filter));
      } catch (e) {
        _addErrorToStream(e);
        if (widget.items.isNotEmpty) {
          _addDataToStream(applyFilter(filter));
        }
      }
    } else {
      _addDataToStream(applyFilter(filter));
    }

    _loadingNotifier.value = false;
  }

  void _addDataToStream(List data) {
    if (_itemsStream.isClosed) return;
    _itemsStream.add(data);
    _currentShowedItems.clear();
    _currentShowedItems.addAll(data);
  }

  void _addErrorToStream(Object error, [StackTrace? stackTrace]) {
    if (_itemsStream.isClosed) return;
    _itemsStream.addError(error, stackTrace);
  }

  Widget _itemWidgetSingleSelection({required item, required int index}) {
    final children = widget.popupProps.itemBuilder(
      context,
      item,
      index,
    );

    return InkWell(
      onTap: () => _handleSelectedItem(item),
      child: IgnorePointer(child: children),
    );
  }

  Widget _searchField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DefaultTextEditingShortcuts(
          child: Shortcuts(
            shortcuts: const <ShortcutActivator, Intent>{
              SingleActivator(LogicalKeyboardKey.space):
                  DoNothingAndStopPropagationTextIntent(),
            },
            child: TextField(
              enableIMEPersonalizedLearning: widget
                  .popupProps.searchFieldProps.enableIMEPersonalizedLearning,
              clipBehavior: widget.popupProps.searchFieldProps.clipBehavior,
              style: widget.popupProps.searchFieldProps.style,
              controller: searchBoxController,
              focusNode: widget.popupProps.searchFieldProps.focusNode,
              autofocus: widget.popupProps.searchFieldProps.autofocus,
              decoration: widget.popupProps.searchFieldProps.decoration,
              keyboardType: widget.popupProps.searchFieldProps.keyboardType,
              textInputAction:
                  widget.popupProps.searchFieldProps.textInputAction,
              textCapitalization:
                  widget.popupProps.searchFieldProps.textCapitalization,
              strutStyle: widget.popupProps.searchFieldProps.strutStyle,
              textAlign: widget.popupProps.searchFieldProps.textAlign,
              textAlignVertical:
                  widget.popupProps.searchFieldProps.textAlignVertical,
              textDirection: widget.popupProps.searchFieldProps.textDirection,
              readOnly: widget.popupProps.searchFieldProps.readOnly,
              contextMenuBuilder:
                  widget.popupProps.searchFieldProps.contextMenuBuilder,
              showCursor: widget.popupProps.searchFieldProps.showCursor,
              obscuringCharacter:
                  widget.popupProps.searchFieldProps.obscuringCharacter,
              obscureText: widget.popupProps.searchFieldProps.obscureText,
              autocorrect: widget.popupProps.searchFieldProps.autocorrect,
              smartDashesType:
                  widget.popupProps.searchFieldProps.smartDashesType,
              smartQuotesType:
                  widget.popupProps.searchFieldProps.smartQuotesType,
              enableSuggestions:
                  widget.popupProps.searchFieldProps.enableSuggestions,
              maxLines: widget.popupProps.searchFieldProps.maxLines,
              minLines: widget.popupProps.searchFieldProps.minLines,
              expands: widget.popupProps.searchFieldProps.expands,
              maxLengthEnforcement:
                  widget.popupProps.searchFieldProps.maxLengthEnforcement,
              maxLength: widget.popupProps.searchFieldProps.maxLength,
              onAppPrivateCommand:
                  widget.popupProps.searchFieldProps.onAppPrivateCommand,
              inputFormatters:
                  widget.popupProps.searchFieldProps.inputFormatters,
              enabled: widget.popupProps.searchFieldProps.enabled,
              cursorWidth: widget.popupProps.searchFieldProps.cursorWidth,
              cursorHeight: widget.popupProps.searchFieldProps.cursorHeight,
              cursorRadius: widget.popupProps.searchFieldProps.cursorRadius,
              cursorColor: widget.popupProps.searchFieldProps.cursorColor,
              selectionHeightStyle:
                  widget.popupProps.searchFieldProps.selectionHeightStyle,
              selectionWidthStyle:
                  widget.popupProps.searchFieldProps.selectionWidthStyle,
              keyboardAppearance:
                  widget.popupProps.searchFieldProps.keyboardAppearance,
              scrollPadding: widget.popupProps.searchFieldProps.scrollPadding,
              dragStartBehavior:
                  widget.popupProps.searchFieldProps.dragStartBehavior,
              enableInteractiveSelection:
                  widget.popupProps.searchFieldProps.enableInteractiveSelection,
              selectionControls:
                  widget.popupProps.searchFieldProps.selectionControls,
              onTap: widget.popupProps.searchFieldProps.onTap,
              mouseCursor: widget.popupProps.searchFieldProps.mouseCursor,
              buildCounter: widget.popupProps.searchFieldProps.buildCounter,
              scrollController:
                  widget.popupProps.searchFieldProps.scrollController,
              scrollPhysics: widget.popupProps.searchFieldProps.scrollPhysics,
              autofillHints: widget.popupProps.searchFieldProps.autofillHints,
              restorationId: widget.popupProps.searchFieldProps.restorationId,
              onChanged: (value) {
                widget.onSearchTextChange(value);
                setState(() {});
              },
            ),
          ),
        )
      ],
    );
  }

  void _handleSelectedItem(newSelectedItem) {
    closePopup();
    widget.onSelect(newSelectedItem);
  }
}
