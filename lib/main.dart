import 'package:flutter/material.dart';
import 'package:satisfaction/send_bot_message.dart';

import 'history_page.dart';
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
  late TextEditingController _name;
  late TextEditingController _type;
  late TextEditingController _summa;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _type = TextEditingController();
    _summa = TextEditingController();
  }

  String priceParser(var a) {



    String result = a.toString();
    String res = '';


    switch (result.length) {
      case 4:
        {
          for (int i = 0; i < result.length; i++) {
            if (i == 1) {
              res += ' ';
            }

            res += result[i];
          }
          break;
        }
      case 5:
        {
          for (int i = 0; i < result.length; i++) {
            if (i == 2) {
              res += ' ';
            }

            res += result[i];
          }
          break;
        }
      case 6:
        {
          for (int i = 0; i < result.length; i++) {
            if (i == 3) {
              res += ' ';
            }

            res += result[i];
          }
          break;
        }
      case 7:
        {
          for (int i = 0; i < result.length; i++) {
            if (i == 1) {
              res += ' ';
            }
            if (i == 4) {
              res += ' ';
            }

            res += result[i];
          }
          break;
        }
      case 8:
        {
          for (int i = 0; i < result.length; i++) {
            if (i == 2) {
              res += ' ';
            }
            if (i == 5) {
              res += ' ';
            }
            if (i == 8) {
              res += ' ';
            }

            res += result[i];
          }
          break;
        }
      case 9:
        {
          for (int i = 0; i < result.length; i++) {
            if (i == 3) {
              res += ' ';
            }
            if (i == 6) {
              res += ' ';
            }
            if (i == 9) {
              res += ' ';
            }
            res += result[i];
          }
          break;
        }
      case 10:
        {
          for (int i = 0; i < result.length; i++) {
            if (i == 1) {
              res += ' ';
            }
            if (i == 4) {
              res += ' ';
            }
            if (i == 7) {
              res += ' ';
            }
            if (i == 10) {
              res += ' ';
            }

            res += result[i];
          }
          break;
        }
    }
    return res;
  }
  var decoration = InputDecoration(
      filled: true,
      fillColor: Colors.blue.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ));

  bool full = true;
  bool loading = false;
  String message = '';

  void accept() async {
    String name = _name.text.toString();
    String type = _type.text.toString();
    String summa = _summa.text.toString();

    print(name);
    print(type);
    print(summa);
    print(full);


    if (name.isEmpty || type.isEmpty || summa.isEmpty) {
      full = false;
      setState(() {});
      return;
    }
    loading = true;

      full = true;
      setState(() {});

    try {


      await NetService.SENDTELEGRAMBOT(name: name, type: type, sum: priceParser(summa));
      loading = false;
setState(() {

});
    } catch (e) {
      message = e.toString();

      full = false;
      loading = false;
      setState(() {});
    }
  }

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
                style: const TextStyle(fontSize: 25, color: Colors.black),
              ),
            ),
            ...text("Имя товара"),
            TextField(controller: _name, decoration: decoration.copyWith(hintText: "Имя товара")),
            ...text("Тип расхода"),
            TextField(controller: _type, decoration: decoration.copyWith(hintText: "Тип расхода")),
            ...text("Общая сумма"),
            TextField(
                controller: _summa,
                keyboardType: TextInputType.number,
                decoration: decoration.copyWith(
                  hintText: "Общая сумма",
                )),
           const SizedBox(
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
                onPressed: accept,
                child:loading?const CircularProgressIndicator():const Text("Сохранить"))
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
