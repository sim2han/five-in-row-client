import 'package:fir_client/constants.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 202,
      height: 100,
      decoration: ShapeDecoration(
        color: Color(0xFFEADDFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Container(
        //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Text(' vs AAAA (650)',
            style: TextStyle(color: MyColor.black, fontSize: 20)),
      ),
    );
  }
}
