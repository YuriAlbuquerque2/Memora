import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:memora/main.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicial();
}

class _TelaInicial extends State<TelaInicial> {

  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          "Memora"
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),

      body: Padding(
        padding: EdgeInsets.only(top: 125),

        child: SizedBox(
          width: double.infinity,

          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.0),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                OutlinedButton(
                  onPressed: () async {
                    await supabase.auth.signOut();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TelaLogin()));
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
                    "Sair",
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