import 'package:fir_client/constants.dart';
import 'package:flutter/material.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({super.key});

  @override
  _WaitingPage createState() => _WaitingPage();
}

class _WaitingPage extends State<WaitingPage> {
  String inputText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("wating your opponent..."),
          backgroundColor: MyColor.appBar,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: MyColor.surface,
          child: Column(children: [
            Container(
                width: double.infinity,
                height: 500,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const SizedBox(height: 200),
                    Container(
                      width: 312,
                      height: 80,
                      padding: const EdgeInsets.only(bottom: 8),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF3EDF7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x26000000),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                            spreadRadius: 2,
                          ),
                          BoxShadow(
                            color: Color(0x4C000000),
                            blurRadius: 2,
                            offset: Offset(0, 1),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            padding: const EdgeInsets.only(
                              top: 12,
                              left: 16,
                              right: 16,
                              bottom: 4,
                            ),
                            child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    'Waiting for your opponent...',
                                    style: TextStyle(
                                      color: Color(0xFF49454F),
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      height: 0.10,
                                      letterSpacing: 0.10,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    '5min',
                                    style: TextStyle(
                                      color: Color(0xFF49454F),
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.10,
                                      letterSpacing: 0.25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ))
          ]),
        ));
  }
}
