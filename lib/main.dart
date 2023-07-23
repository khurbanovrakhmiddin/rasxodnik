import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:satisfaction/send_bot_message.dart';
import 'firebase_options.dart';
import 'history_page.dart';
import 'netservice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...

/// ```
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('history');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  late TextEditingController _type;
  late TextEditingController _summa;
bool hide = false;
  bool full = true;
  bool loading = false;
  String message = '';
  List rasxod = [];
  FocusNode focus = FocusNode();
  var box = Hive.box('history');

  @override
  void initState() {
    super.initState();
    _type = TextEditingController();
    _summa = TextEditingController();
    rasxod = box.values.toList();
  }

  String priceParser(var a) {
    String result = a.toString();
    String res = '';

    switch (result.length) {
      case 4:
        {
          for (int i = 0; i < result.length; i++) {
            if (i == 1) {
              res += '-';
            }

            res += result[i];
          }
          break;
        }
      case 5:
        {
          for (int i = 0; i < result.length; i++) {
            if (i == 2) {
              res += '-';
            }

            res += result[i];
          }
          break;
        }
      case 6:
        {
          for (int i = 0; i < result.length; i++) {
            if (i == 3) {
              res += '-';
            }

            res += result[i];
          }
          break;
        }
      case 7:
        {
          for (int i = 0; i < result.length; i++) {
            if (i == 1) {
              res += '-';
            }
            if (i == 4) {
              res += '-';
            }

            res += result[i];
          }
          break;
        }
      case 8:
        {
          for (int i = 0; i < result.length; i++) {
            if (i == 2) {
              res += '-';
            }
            if (i == 5) {
              res += '-';
            }
            if (i == 8) {
              res += '-';
            }

            res += result[i];
          }
          break;
        }
      case 9:
        {
          for (int i = 0; i < result.length; i++) {
            if (i == 3) {
              res += '-';
            }
            if (i == 6) {
              res += '-';
            }
            if (i == 9) {
              res += '-';
            }
            res += result[i];
          }
          break;
        }
      case 10:
        {
          for (int i = 0; i < result.length; i++) {
            if (i == 1) {
              res += '-';
            }
            if (i == 4) {
              res += '-';
            }
            if (i == 7) {
              res += '-';
            }
            if (i == 10) {
              res += '-';
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

  void accept() async {
    // String name = _name.text.toString();
    String type = _type.text.toString();
    String summa = _summa.text.toString();

    print(type);
    print(summa);
    print(full);

    if (type.isEmpty || summa.isEmpty) {
      full = false;
      message = 'jo xoli';
      setState(() {});
      return;
    }
    loading = true;

    full = true;
    setState(() {});

    try {
      await NetService.SENDTELEGRAMBOT(type: type, sum: priceParser(summa));
      loading = false;
      message = 'Успешно!!';

      if (!rasxod.contains(_type.text)) {
        box.add(_type.text);
        rasxod.add(_type.text);
      }
      hide = false;


      _type.clear();
      _summa.clear();
      focus.requestFocus();
      setState(() {});
    } catch (e) {
      message = e.toString();

      full = false;
      hide = false;

      loading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : true,


      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  message,
                  style: TextStyle(fontSize: 25, color: message == "Успешно!!" ? Colors.green : Colors.red),
                ),
              ),
              Center(
                child: Text(
                  "Расходы ${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                  style: const TextStyle(fontSize: 25, color: Colors.black),
                ),
              ),
              // ...text("Имя товара"),
              // TextField(controller: _name, decoration: decoration.copyWith(hintText: "Имя товара")),
              ...text("Тип расхода"),
              TextField(
                  onTap: (){

                    hide = true;


                    setState(() {

                    });
                  },
                  focusNode: focus, controller: _type, decoration: decoration.copyWith(hintText: "Тип расхода")),

              hide?
              Wrap(
                children: rasxod
                    .map((e) => ActionChip(
                  onPressed: () {
                    _type.text = e;
                    setState(() {});
                  },
                  backgroundColor: _type.text == e ? Colors.yellowAccent : Colors.white,
                  label: Text(e),
                ))
                    .toList(),
              ):const SizedBox.shrink(),
              ...text("Общая сумма"),
              TextField(



                  onTap: (){

                    hide = false;
                    setState(() {

                    });
                  },
                  inputFormatters: [NumberTextInputFormatter()],

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
                      backgroundColor: MaterialStateProperty.all(Colors.blue.shade300),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ))),
                  onPressed: accept,
                  child: loading
                      ? const CircularProgressIndicator()
                      : const Text(
                    "Сохранить",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  )),


            ]
        ),
      )
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

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 1;
    final newTextBuffer = StringBuffer();
   var r = newValue.text.trim();
  r = r.replaceAll(' ', '');
    var s = priceParser(r);
    print(s);

    return TextEditingValue(
      text: s.toString(),
      selection: TextSelection.collapsed(offset: s.length),
    );


  }
  String priceParser(var a) {



    String result = a.toString();
    String res = '';
    String replace = "-";
print(result.length);
    switch (result.length) {

      case 1: return result;
      case 2: return result;
      case 3: return result;
      case 4:
        {
          for (int i = 0; i < result.length; i++) {
            if (i == 1) {
              res += replace;
            }

            res += result[i];
          }
          break;
        }
      case 5:
        {
          for (int i = 0; i < result.length; i++) {
            if (i == 2) {
              res += replace;
            }

            res += result[i];
          }
          break;
        }
      case 6:
        {
          for (int i = 0; i < result.length; i++) {
            if (i == 3) {
              res += replace;
            }

            res += result[i];
          }
          break;
        }
      case 7:
        {
          for (int i = 0; i < result.length; i++) {
            if (i == 1) {
              res += replace;
            }
            if (i == 4) {
              res += replace;
            }

            res += result[i];
          }
          break;
        }
      case 8:
        {
          for (int i = 0; i < result.length; i++) {
            if (i == 2) {
              res += replace;
            }
            if (i == 5) {
              res += replace;
            }
            if (i == 8) {
              res += replace;
            }

            res += result[i];
          }
          break;
        }
      case 9:
        {
          for (int i = 0; i < result.length; i++) {
            if (i == 3) {
              res += replace;
            }
            if (i == 6) {
              res += replace;
            }
            if (i == 9) {
              res += replace;
            }
            res += result[i];
          }
          break;
        }
      case 10:
        {
          for (int i = 0; i < result.length; i++) {
            if (i == 1) {
              res += replace;
            }
            if (i == 4) {
              res += replace;
            }
            if (i == 7) {
              res += replace;
            }
            if (i == 10) {
              res += replace;
            }

            res += result[i];
          }
          break;
        }
    }
    return res;
  }

}
