import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:memora/cadastro.dart';
import 'package:memora/telainicial.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize( // inicialização do banco de dados
    url: 'https://yseqvbbrcihjxlgwdhsw.supabase.co',
    publishableKey: 'sb_publishable_1hHOXT3DbrfqJoWVhYumCA_sCeNOrx_',
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client; // variável de usuário do banco

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 18, 32, 47)),
      ),
      home: supabase.auth.currentUser == null ? TelaLogin() : TelaInicial(),
    );
  }
}

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {

  // controladores dos campos de texto da tela
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
    return Scaffold(
      body: Padding ( // distanciar título do topo da tela
        padding: const EdgeInsets.only(top: 125),
        child: SizedBox( // fazer os filhos da SizedBox ocuparem toda a largura da tela    
          width: double.infinity,
          child: Padding ( // manter filhos do Padding centralizados com margem lateral
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
          
            child: Column( // elementos da tela um abaixo do outro
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text( // texto de título
                  "Bem-vindo ao",
                  style: TextStyle(
                    fontSize: 50,
                   fontWeight: FontWeight.bold,
                   height: 1.0
                  ),
                ),

                Text( // texto de título
                 "MEMORA",
                 style: TextStyle(
                    fontSize: 50,
                   fontWeight: FontWeight.bold,
                 ),
                ),

                Text( // texto de subtítulo
                  "Seu assistente de memória pessoal",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox( // espaçamento entre elementos
                  height: 100,
                ),

               Text(
                  "Entre em sua conta",
                  style: TextStyle(
                    fontSize: 20,
                 ),
                ),

                SizedBox( // espaçamento entre elementos
                  height: 15,
                ),

                TextFormField( // campo de email
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

              SizedBox( // espaçamento entre elementos
                  height: 25,
                ),

                TextFormField( // campo de senha
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

              SizedBox( // espaçamento entre elementos
                  height: 25,
                ),

                OutlinedButton( // botão de fazer login
                  onPressed: () async {
                    if (emailController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Informe seu email!")));
                      return;
                    }

                    if (senhaController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Informe sua senha")));
                      return;
                    }

                    try {
                      
                      await supabase.auth.signInWithPassword(
                        email: emailController.text.trim(),
                        password: senhaController.text,
                      );
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaInicial()));
                    } catch (e) {

                      print(e);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email ou senha incorretos")));
                    }

                    
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

                  child: Text( // texto do botão de fazer login
                    textAlign: TextAlign.center,
                    "Entrar",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),

                SizedBox ( // espaçamento entre elementos
                  height: 75,
                ),

                Row( // elementos da tela um ao lado do outro
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 5.0,

                  children: [

                    Text(
                      textAlign: TextAlign.start,
                      "Não possui uma conta?",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),

                    Text(
                      textAlign: TextAlign.justify,
                      "Crie agora!",
                      style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),

                SizedBox( // espaçamento entre elementos
                  height: 15,
                ),

                OutlinedButton( // botão de ir para tela de cadastro
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TelaCadastro()));
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

                  child: Text( // texto do botão de ir para tela de cadastro
                    textAlign: TextAlign.center,
                    "Criar conta",
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
