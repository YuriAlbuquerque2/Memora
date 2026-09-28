import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://yseqvbbrcihjxlgwdhsw.supabase.co',
    publishableKey: 'sb_publishable_1hHOXT3DbrfqJoWVhYumCA_sCeNOrx_',
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 18, 32, 47)),
      ),
      home: TelaLogin(),
      //home: supabase.auth.currentUser == null ? TelaLogin() : TelaInicial(),
    );
  }
}

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  void dispose() {
    // Limpa os controladores quando a tela for fechada
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Padding (
        padding: const EdgeInsets.only(top: 125),
        child: SizedBox(              
          width: double.infinity,
          child: Padding (
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
          
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text(
                  "Bem-vindo ao",
                  style: TextStyle(
                    fontSize: 50,
                   fontWeight: FontWeight.bold,
                   height: 1.0
                  ),
                ),

                Text(
                 "MEMORA",
                 style: TextStyle(
                    fontSize: 50,
                   fontWeight: FontWeight.bold,
                 ),
                ),

                SizedBox(
                  height: 150,
                ),

               Text(
                  "Entre em sua conta",
                  style: TextStyle(
                    fontSize: 20,
                 ),
                ),

                SizedBox(
                  height: 15,
                ),

                TextFormField(
                 controller: emailController,
                 style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                 keyboardType: TextInputType.emailAddress,
                 decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                     color: Color.fromARGB(255, 200, 200, 200),
                     fontStyle: FontStyle.italic,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                     borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0),
                     ),
                   ),

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                         color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),

                     errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),

                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    prefixIcon: Icon(Icons.email),
                ),
              ),

              SizedBox(
                  height: 25,
                ),

                TextFormField(
                 controller: senhaController,
                 obscureText: true,
                 style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                 keyboardType: TextInputType.visiblePassword,
                 decoration: InputDecoration(
                    hintText: 'Senha',
                    hintStyle: TextStyle(
                     color: Color.fromARGB(255, 200, 200, 200),
                     fontStyle: FontStyle.italic,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                     borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0),
                     ),
                   ),

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                         color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),

                     errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),

                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    prefixIcon: Icon(Icons.key),
                ),
              ),

              SizedBox(
                  height: 25,
                ),

                OutlinedButton(
                  onPressed: () async {
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaInicial()));
                  },

                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(200, 50),
                    foregroundColor: Color.fromARGB(255, 0, 0, 0),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),

                  child: Text(
                    textAlign: TextAlign.center,
                    "Entrar",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
