import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MatchButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 96,
          height: 120,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 96,
                  height: 96,
                  padding: const EdgeInsets.all(20),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFFEADDFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: SvgPicture.asset(
                      'assets/icons/arrow_forward_24dp_000000_FILL1_wght200_GRAD0_opsz24.svg',
                      fit: BoxFit.fill)),
              SizedBox(
                width: double.infinity,
                child: Text(
                  '5min',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1D1B20),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 0.10,
                    letterSpacing: 0.10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
