import 'package:flutter/material.dart';
import '/globals.dart' as globals;
import '/screens/selectscreen.dart';
import '/modules/l108.dart';

class SelectButton extends StatefulWidget {
  const SelectButton(
      {Key? key,
      required this.item,
      //required this.items,
      //required this.tapMethod,
      required this.buttonName})
      : super(key: key);

  final item;
  //final items;

  //final Function tapMethod;
  final String buttonName;

  @override
  _SelectButton createState() => _SelectButton();
}

class _SelectButton extends State<SelectButton> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    //widget.tapMethod();
    showWindow();
  }

  void showWindow() {
    print(widget.item);
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => SelectScreen()));

    globals.setState(() {
      //globals.filterItemsAll();

      globals.isWindowShown[widget.item] = true;

      globals.isSearchShown = true;
      //print("222");

      //print(globals.isWindowShown);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTap: _handleTap,
        onTapCancel: _handleTapCancel,
        child: Container(
          child: Row(
            children: [
              Expanded(
                  child: Align(
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                        //Column(children: [
                        Text(widget.buttonName,
                            style: TextStyle(fontSize: 29.0 /*19 */, color: _highlight ? globals.config["forecolor"] : globals.config["forecolor3"])),
                        if (globals.l108t(widget.buttonName) != "")
                          Text(globals.l108t(widget.buttonName),
                              style: TextStyle(fontSize: 20/*12.0*/, color: _highlight ? globals.config["forecolor5"] : globals.config["forecolor4"]))
                      ]

                          //)
                          //]
                          ),
                      alignment: Alignment(0, 0))),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: _highlight ? globals.config["forecolor2"] : globals.config["forecolor"],
              ),
            ],
          ),
          width: 300.0,
          height: 120.0,
          padding: EdgeInsets.only(left: 15.0, right: 5.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: _highlight ? globals.config["forecolor2"] : globals.config["forecolor"],
              width: 2.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ));
  }
}
