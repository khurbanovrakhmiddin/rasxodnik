import 'package:flutter/material.dart';
import 'package:satisfaction/send_bot_message.dart';

import 'netservice.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var decoration = InputDecoration(
      filled: true,
      fillColor: Colors.blue.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Расходы ${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
            ),
            ...text("Имя товара"),
            TextField(decoration: decoration.copyWith(hintText: "Имя товара")),
            ...text("Тип расхода"),
            TextField(decoration: decoration.copyWith(hintText: "Тип расхода")),
            ...text("Общая сумма"),
            TextField(
                keyboardType: TextInputType.number,
                decoration: decoration.copyWith(
                  hintText: "Общая сумма",
                )),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(4),
                    minimumSize: MaterialStateProperty.all(const Size(double.infinity, 48)),
                    maximumSize: MaterialStateProperty.all(const Size(double.infinity, 48)),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.greenAccent,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ))),
                onPressed: () {},
                child: Text("Сохранить"))
          ],
        ),
      ),
    );
  }

  List<Widget> text(String text) {
    return [
      const SizedBox(
        height: 15,
      ),
      Text(text),
      const SizedBox(
        height: 15,
      ),
    ];
  }
}
