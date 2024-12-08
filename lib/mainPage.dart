import 'package:fir_client/constants.dart';
import 'package:fir_client/engine.dart';
import 'package:fir_client/gameViewPage.dart';
import 'package:fir_client/loginPage.dart';
import 'package:flutter/material.dart';
import 'ratingWidget.dart';
import 'fastMatchingWidget.dart';

// Generated by: https://www.figma.com/community/plugin/842128343887142055/
class MainPage extends StatelessWidget with RouteAware {
  const MainPage({super.key});

  @override
  void didPopNext() {
    super.didPopNext();
    Engine().refresh();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text("Welcome to Five-in-row!")),
        body: Column(children: [
          const TopAppBar(),
          const RatingWidget(),
          fastMatchingWidget(),
          Container(
              width: double.infinity,
              height: 50,
              color: MyColor.surface,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Previous Games",
                  style: TextStyle(fontSize: 22, color: MyColor.text))),
          Expanded(
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: MyColor.surface,
                  padding: const EdgeInsets.all(10),
                  child: ValueListenableBuilder<Infos>(
                      valueListenable: Engine().notifier,
                      builder: (context, infos, _) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: infos.gameinfos.length,
                          itemBuilder: (context, index) {
                            String oppname = '';
                            if (infos.gameinfos[index].blackname !=
                                infos.userinfo.id) {
                              oppname = infos.gameinfos[index].blackname;
                            } else {
                              oppname = infos.gameinfos[index].whitename;
                            }
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: GestureDetector(
                                    onTap: () {
                                      Engine().selectedGame = index;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GameViewPage()));
                                    },
                                    child: Container(
                                      width: 202,
                                      height: 100,
                                      padding: const EdgeInsets.all(10),
                                      decoration: ShapeDecoration(
                                        color: MyColor.primaryContainer,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text(' vs $oppname',
                                          style: TextStyle(
                                              color: MyColor.black,
                                              fontSize: 20)),
                                    )));
                          },
                        );
                      })))
        ]),
      ),
    );
  }
}

class TopAppBar extends StatelessWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 116,
          padding: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(color: MyColor.surface),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              IconButton(
                  iconSize: 40,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  icon:
                      const Icon(Icons.person_2_outlined, color: Colors.black)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueListenableBuilder<Infos>(
                        valueListenable: Engine().notifier,
                        builder: (context, value, _) {
                          String text;
                          if (value.loginState == false) {
                            text = 'Hello, guest!';
                          } else {
                            text = 'Hello, ${value.userinfo.id}!';
                          }
                          return Text(
                            text,
                            style: TextStyle(color: MyColor.text, fontSize: 22),
                          );
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
