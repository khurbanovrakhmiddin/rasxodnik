import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:satisfaction/send_bot_message.dart';

import 'netservice.dart';

void main()async {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Расходы ${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}"),
        TextField(),
        TextField(),
          TextField(

            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              counterStyle: const TextStyle(
                height: double.minPositive,
              ),
              counterText: "",

              hintStyle: Theme.of(context).textTheme
                  .headline3?.copyWith(color: Colors.grey),
              hintText: "(90) 123 45 67",


              border: OutlineInputBorder(

                  borderRadius:
                  BorderRadius.circular(
                      8),
                  borderSide: BorderSide(
                      color: Colors
                          .grey.shade300),
                  gapPadding: 1),
              focusedBorder:
              OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors
                          .grey.shade300),
                  borderRadius:
                  BorderRadius
                      .circular(8),
                  gapPadding: 1),
            ),

          ),
          SizedBox(height: 50,),

          ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(4),
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 48)),
                  maximumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 48)),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.greenAccent,
                  ),
                  shape: MaterialStateProperty.all<
                      RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ))),
              onPressed: (){}, child: Text("Сохранить"))
      ],),
    );
  }
}
