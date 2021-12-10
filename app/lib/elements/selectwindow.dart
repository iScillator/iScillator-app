import 'package:flutter/material.dart';

import '/globals.dart' as globals;

class SelectWindow extends StatelessWidget {
  const SelectWindow({
    Key? key,
    required this.item,
    required this.items,
    //required this.selectItem,
    //required this.selectedItem
  }) : super(key: key);

  final item;
  final items;
  //final Function selectItem;
  //final int selectedItem;

  void selectItem(int num) {
    globals.setState(() {
      if (num == -1) {
        globals.isWindowShown[item] = false;
      } else {
        globals.selected[item] = num;
        globals.userSettings[item] =
            globals.menu[item].values.toList()[num]; //was audio=
        globals.isWindowShown[item] = false;
        globals.setParams();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 30, bottom: 30),
        color: Colors.white60,
        child: SafeArea(
            child: Container(
                constraints: BoxConstraints(maxWidth: 350),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(7, 117, 229, 1.0),
                          Color.fromRGBO(12, 232, 92, 1.0),
                        ]),
                    border: Border.all(width: 3, color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          iconSize: 35,
                          onPressed: () {
                            selectItem(-1);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ))),
                  Expanded(
                      child: ListView.builder(
                          itemCount: items.keys.toList().length,
                          itemBuilder: (context, index) {
                            return Column(children: [
                              ListTile(
                                title: Align(
                                    child: Text(
                                      items.keys.toList()[index],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 23.0),
                                    ),
                                    alignment: globals.selected[item] == index
                                        ? Alignment(-1.8, 0)
                                        : Alignment(-0.3, 0)),
                                onTap: () {
                                  selectItem(index);
                                },
                                leading: globals.selected[item] == index
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                              Divider(
                                indent: 20,
                                endIndent: 20,
                                color: Colors.white,
                              )
                            ]);
                          }))
                ]))));
  }
}
