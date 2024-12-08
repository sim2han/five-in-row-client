import 'package:fir_client/constants.dart';
import 'package:fir_client/engine.dart';
import 'package:fir_client/gamePage.dart';
import 'package:fir_client/waitingPage.dart';
import 'package:flutter/material.dart';

class MatchButtonWidget extends StatelessWidget {
  const MatchButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: MyColor.buttonColor),
                  child: IconButton(
                      iconSize: 80,
                      alignment: Alignment.center,
                      onPressed: () {
                        Engine().enterGame(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GamePage()));
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WaitingPage()));
                      },
                      icon: const Icon(Icons.arrow_forward,
                          color: Colors.white))),
              const SizedBox(height: 10),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'play 8x8',
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
