import 'package:dbms_project/utils/utils.dart';
import 'package:dbms_project/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDown<T> extends StatefulWidget {
  final String? title;
  final String? hint;
  final String? initialText;
  final List<T> list;
  final bool isMultiSelect;
  final TextEditingController? controller;
  final void Function(T, int)? callback;
  final String Function(T)? displayText;
  final String Function(T)? queryText;
  final Function? onPopUpOn;
  final Function? onPopUpClose;
  final Widget Function(T, bool)? listTile;
  const DropDown({
    this.title,
    this.hint,
    this.initialText,
    required this.list,
    this.callback,
    this.displayText,
    this.queryText,
    this.onPopUpOn,
    this.onPopUpClose,
    this.listTile,
    this.isMultiSelect = false,
    this.controller,
  });

  @override
  State<DropDown<T>> createState() => _DropDownState<T>();
}

class _DropDownState<T> extends State<DropDown<T>> {
  late final textEditingController;
  @override
  void initState() {
    if (widget.controller == null) {
      textEditingController = TextEditingController();
    } else {
      textEditingController = widget.controller;
    }
    if (widget.initialText != null) {
      textEditingController.text = widget.initialText!.trim().toString();
      // print(textEditingController.text);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () async {
        if (widget.onPopUpOn != null) widget.onPopUpOn!();

        final response = await showDialog<T?>(
          context: context,
          builder: (context) {
            return Dialog(
              insetPadding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.0426,
              ),
              child: SearchList<T>(
                list: widget.list,
                hint: widget.hint,
                title: widget.title,
                callback: widget.callback,
                displayText: widget.displayText,
                queryText: widget.queryText,
                listTile: widget.listTile,
                isMultiSelect: widget.isMultiSelect,
              ),
            );
          },
        );
        if (widget.onPopUpClose != null) widget.onPopUpClose!();
        if (response != null) {
          setState(() {
            if (widget.displayText != null) {
              // print("Selected: ");
              // print(widget.displayText!(response));
              textEditingController.text = widget.displayText!(response);
            } else {
              textEditingController.text = response.toString();
            }
          });
        }
      },
      readOnly: true,
      textAlign: TextAlign.start,
      controller: textEditingController,
      style: defaultTextStyle.copyWith(color: const Color(0xff0e1d2c)),
      decoration: InputDecoration(
        hintText: widget.hint,
        isDense: true,
        border: InputBorder.none,
        hintStyle: defaultTextStyle.copyWith(color: Colors.grey[500]),
        contentPadding: const EdgeInsets.only(left: 8, top: 12),
        suffixIcon: Icon(
          Icons.keyboard_arrow_down_outlined,
          color: Colors.grey[500],
          size: 16,
        ),
      ),
    );
  }
}

class SearchList<T> extends StatefulWidget {
  final String? title;
  final String? hint;
  final List<T> list;
  final void Function(T, int)? callback;
  final String Function(T)? displayText;
  final String Function(T)? queryText;
  final Widget Function(T, bool)? listTile;
  final bool isMultiSelect;
  const SearchList({
    Key? key,
    this.hint,
    this.title,
    required this.list,
    this.callback,
    this.displayText,
    this.queryText,
    this.listTile,
    this.isMultiSelect = false,
  }) : super(key: key);

  @override
  State<SearchList<T>> createState() => _SearchListState<T>();
}

class _SearchListState<T> extends State<SearchList<T>> {
  late final List<_ListElement<T>> _net_elements;
  late List<int> _current_elements;
  late final Widget Function(T, bool) _listTile;
  List<int> _selected_elements = [];
  late String Function(T) _queryText;
  late String Function(T) _displayText;
  final _searchController = TextEditingController();

  @override
  void initState() {
    _net_elements = [];
    _queryText = widget.queryText ?? (T e) => e.toString();
    _displayText = widget.displayText ?? (T e) => e.toString();
    _listTile = widget.listTile ??
        (T e, bool s) => ListTile(
              title: Text(_displayText(e)),
            );
    for (T e in widget.list) {
      _net_elements.add(_ListElement(
        element: e,
        selected: false,
        queryText: _queryText(e),
        displayText: _displayText(e),
      ));
    }
    _current_elements = List.generate(_net_elements.length, (index) => index);
    super.initState();
  }

  void _query(String text) {
    text = text.trim();
    if (text != "") {
      // print(text.toLowerCase());
      setState(() {
        // print(_current_elements.length);
        _current_elements.clear();
        // print(_current_elements.length);
        for (int i = 0; i < _net_elements.length; i++) {
          if (_net_elements[i]
              .queryText
              .toLowerCase()
              .contains(text.toLowerCase())) {
            _current_elements.add(i);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _buttonColor = _selected_elements.isEmpty
        ? const Color.fromRGBO(165, 178, 190, 1)
        : Colors.green;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      // padding: null,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  right: 20,
                  left: 20,
                  bottom: 10,
                ),
                child: Text(
                  widget.title.toString(),
                  style: defaultTextStyle.copyWith(
                    fontSize: bigTextSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(Icons.search),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: widget.hint,
                        ),
                        onChanged: (val) {
                          _query(val);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: smallHP),
            constraints: BoxConstraints(maxHeight: height * 0.4),
            child: ListView.builder(
              itemCount: _current_elements.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final i = _current_elements[index];
                return GestureDetector(
                  onTap: () {
                    if (widget.callback != null) {
                      widget.callback!(_net_elements[i].element, i);
                    }

                    if (!widget.isMultiSelect) {
                      if (_net_elements[i].selected) {
                        _selected_elements.clear();
                      } else {
                        if (_selected_elements.isNotEmpty) {
                          _net_elements[_selected_elements.first].selected =
                              false;
                        }
                        _selected_elements.clear();
                        _selected_elements.add(i);
                      }
                    } else {
                      if (!widget.isMultiSelect) {
                        if (_net_elements[i].selected) {
                          _selected_elements.remove(i);
                        } else {
                          _selected_elements.add(i);
                        }
                      }
                    }
                    _net_elements[i].selected = !_net_elements[i].selected;
                    setState(() {});
                  },
                  child: _listTile(
                      _net_elements[i].element, _net_elements[i].selected),
                );
              },
            ),
          ),
          SizedBox(
            height: smallVP,
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[200],
          ),
          SizedBox(
            height: smallVP,
          ),
          GoodButton(
            text: 'Done',
            customWidth: width * 0.8,
            bgColor: _buttonColor,
            borderColor: _buttonColor,
            textColor: Colors.white,
            onTap: () {
              if (_selected_elements.isEmpty) {
                Navigator.of(context).pop();
                return;
              }
              if (!widget.isMultiSelect) {
                Navigator.of(context)
                    .pop(_net_elements[_selected_elements.first].element);
                return;
              }
              Navigator.of(context).pop(_selected_elements
                  .map((e) => _net_elements[e].element)
                  .toList());
              return;
            },
          ),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style:
                    defaultTextStyle.copyWith(color: const Color(0xff5580FF)),
              ),
            ),
          ),
          SizedBox(
            height: smallVP,
          ),
        ],
      ),
    );
  }
}

class _ListElement<T> {
  final T element;
  bool selected;
  final String queryText;
  final String displayText;
  _ListElement({
    required this.element,
    required this.selected,
    required this.displayText,
    required this.queryText,
  });
}
