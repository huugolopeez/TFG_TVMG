import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../singletone/DataHolder.dart';

class TMGrid extends StatelessWidget {
  final String sTitle;
  final String sBody;
  final double dFontSize;
  final int iPosition;
  final Function(int indice)? onItemTap;

  const TMGrid(
      {super.key,
      required this.sTitle,
      required this.sBody,
      required this.dFontSize,
      required this.iPosition,
      required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onItemTap!(iPosition);
        },
        child: FractionallySizedBox(
            widthFactor: 0.95,
            heightFactor: 0.95,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: DataHolder().colorPrincipal),
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(children: [
                      Expanded(
                          child: Image(
                            image: NetworkImage(sBody),
                          )),
                      Text(sTitle,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1,
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: dFontSize,
                          )),
                    ])))));
  }
}
