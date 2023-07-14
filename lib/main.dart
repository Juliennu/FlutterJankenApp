import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Hand myHand = Hand.rock;
  Hand computerHand = Hand.rock;
  Result result = Result.draw;

  void jankenAction(Hand myHand) {
    setState(() {
      this.myHand = myHand;
      chooseComputerJankenText();
    });
  }

  void chooseComputerJankenText() {
    final randomNumber = Random().nextInt(3);
    final hand = Hand.values[randomNumber];

    setState(() {
      computerHand = hand;
    });
    decideResult();
  }

  void decideResult() {
    final Result result;

    // じゃんけんアルゴリズム参照: https://qiita.com/mpyw/items/3ffaac0f1b4a7713c869
    if (myHand == computerHand) {
      result = Result.draw;
    } else if ((myHand.index - computerHand.index + 3) % 3 == 2) {
      result = Result.win;
    } else if ((myHand.index - computerHand.index + 3) % 3 == 1) {
      result = Result.lose;
    } else {
      result = Result.draw; // ここに来ることはない想定
    }

    setState(() {
      this.result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '相手',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              computerHand.text,
              style: TextStyle(fontSize: 100),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              result.text,
              style: TextStyle(fontSize: 50),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              myHand.text,
              style: TextStyle(fontSize: 100),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              jankenAction(Hand.rock);
            },
            tooltip: 'Increment',
            child: const Text(
              '✊',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          FloatingActionButton(
            onPressed: () {
              jankenAction(Hand.scissors);
            },
            tooltip: 'Increment',
            child: const Text(
              '✌️',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          FloatingActionButton(
            onPressed: () {
              jankenAction(Hand.paper);
            },
            tooltip: 'Increment',
            child: const Text(
              '✋',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

enum Hand {
  rock,
  scissors,
  paper;

  String get text {
    switch (this) {
      case Hand.rock:
        return '✊';
      case Hand.scissors:
        return '✌️';
      case Hand.paper:
        return '✋';
    }
  }
}

enum Result {
  win,
  lose,
  draw;

  String get text {
    switch (this) {
      case Result.win:
        return '勝ち';
      case Result.lose:
        return '負け';
      case Result.draw:
        return 'あいこ';
    }
  }
}