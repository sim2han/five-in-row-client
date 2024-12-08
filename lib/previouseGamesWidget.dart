import 'package:fir_client/constants.dart';
import 'package:fir_client/engine.dart';
import 'package:flutter/material.dart';

class PreviouseGameWidget extends StatelessWidget {
  const PreviouseGameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Infos>(
        valueListenable: Engine().notifier,
        builder: (context, infos, _) {
          return Expanded(
              child: Column(
            children: [
              Text("Previous Games",
                  style: TextStyle(fontSize: 22, color: MyColor.text)),
              const SizedBox(height: 10),
            ],
          ));
        });
  }
}
