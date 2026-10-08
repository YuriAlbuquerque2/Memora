import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:memora/main.dart';
import 'package:memora/functions/categoriasAutomaticas.dart';

class TelaCadastro extends StatefulWidget {
  final ThemeMode temaSelecionado;
  final Function(ThemeMode) aoMudarTema;

  const TelaCadastro({super.key, required this.temaSelecionado, required this.aoMudarTema});

  @override
  State<TelaCadastro> createState() => _TelaCadastro();
}

class _TelaCadastro extends State<TelaCadastro> {
  
  // controladores dos campos de texto
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController = TextEditingController();

  @override
  void dispose() {
    // Limpa os controladores quando a tela for fechada
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        
          width: double.infinity,
          height: double.infinity,
          
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                isDarkMode ? 'imagens/Fundo_escuro.png' : 'imagens/Fundo_claro.png',
              ),
              fit: BoxFit.cover,
            ),
          ),

        child: Padding(
          padding: const EdgeInsets.only(top: 125),

          child: SizedBox(
            width: double.infinity,

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),

              child: Column(

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
                    "Crie sua conta",
                    style: TextStyle(
                      fontSize: 20,
                  ),
                  ),

                  SizedBox( // espaçamento entre elementos
                    height: 15,
                  ),

                  TextFormField( // campo de nome
                  controller: nomeController,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      hintText: 'Nome',
                      hintStyle: TextStyle(
                      color: Color.fromARGB(255, 200, 200, 200),
                      fontStyle: FontStyle.italic,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                      ),
                    ),

                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
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
                      prefixIcon: Icon(Icons.abc),
                  ),
                ),

                SizedBox( // espaçamento entre elementos
                    height: 25,
                  ),

                  TextFormField( // campo de email
                  controller: emailController,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
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
                          color: Theme.of(context).colorScheme.primary,
                      ),
                    ),

                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
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
                      color: Theme.of(context).textTheme.bodyLarge?.color,
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
                          color: Theme.of(context).colorScheme.primary,
                      ),
                    ),

                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                          color:Theme.of(context).colorScheme.primary,
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

                  TextFormField( // campo de confirmar senha
                  controller: confirmarSenhaController,
                  obscureText: true,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      hintText: 'Confirmar Senha',
                      hintStyle: TextStyle(
                      color: Color.fromARGB(255, 200, 200, 200),
                      fontStyle: FontStyle.italic,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                      ),
                    ),

                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
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
                    height: 35,
                  ),

                  OutlinedButton( // botão de criar conta e voltar para tela de login
                    onPressed: () async {
                      if (nomeController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Informe um nome!")));
                        return;
                      }

                      if (emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Informe um email!")));
                        return;
                      }

                      if (!emailController.text.contains('@')) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Informe um email válido!")));
                        return;
                      }

                      if (senhaController.text.length < 8) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("A senha precisa de no mínimo 8 caracteres!")));
                        return;
                      }

                      if (senhaController.text != confirmarSenhaController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Os campos de senha não coincidem!")));
                        return;
                      }

                      final response = await supabase.auth.signUp( // cria a conta no banco
                        email: emailController.text.trim(),
                        password: senhaController.text,
                      );

                      final userId = response.user!.id;

                      await Supabase.instance.client // adiciona informações a tabela 'profiles'
                      .from('profiles')
                      .insert({
                        'id': userId,
                        'name': nomeController.text,
                      });

                      await CategoriasAutomaticas.criarCategoriasPadroes(userId);

                      Navigator.push(context, MaterialPageRoute(builder: (context) => TelaLogin(temaSelecionado: widget.temaSelecionado, aoMudarTema: widget.aoMudarTema,)));
                    },

                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(200, 50),
                      foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),

                    child: Text( // texto do botão
                      textAlign: TextAlign.center,
                      "Cadastrar",
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
      ),
    );
  }
}