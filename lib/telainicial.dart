import 'package:flutter/material.dart';
import 'package:memora/functions/categoriasAutomaticas.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:memora/main.dart';
import 'package:memora/registro.dart';

class TelaInicial extends StatefulWidget {
  final ThemeMode temaSelecionado;
  final Function(ThemeMode) aoMudarTema;

  const TelaInicial({super.key, required this.temaSelecionado, required this.aoMudarTema});

  @override
  State<TelaInicial> createState() => _TelaInicial();
}

class _TelaInicial extends State<TelaInicial> {

  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> memorias = [];
  List<Map<String, dynamic>> categoriasPadroes = [];
  bool carregando = true;
  bool isSearchClicked = false;
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    carregarCategoriasPadroes();
    carregarMemorias();
  }

  Future<void> carregarCategoriasPadroes() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;

    if (userId == null) return;

    final categoriasCarregadas =
        await CategoriasAutomaticas.lerCategoriasPadroes(userId);

    setState(() {
      categoriasPadroes = categoriasCarregadas;
    });
    }

  Future<void> carregarMemorias() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      return;
    }

    final registrosRecentes = await supabase
    .from('memories')
    .select('''
      id,
      content,
      updated_at,
      category_id,
      categories (
        name,
        icon
      )
    ''')
    .eq('user_id', user.id)
    .order('updated_at', ascending: false)
    .limit(2);

    setState(() {
      memorias = List<Map<String, dynamic>>.from(registrosRecentes);
    });
  }

  Widget categoriaBotao(Map<String, dynamic> categoria) {
    return SizedBox(
      height: 55,
      child: OutlinedButton(
        onPressed: () {
          // abrir categoria
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              getCategoryIcon(
                categoria['icon'].toString(),
              ),
              size: 25,
            ),

            const SizedBox(width: 8),

            Text(
              categoria['name'].toString(),
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData getCategoryIcon(String icon) {
  switch (icon) {
    case 'saude':
      return Icons.local_hospital;

    case 'carrinho_de_compras':
      return Icons.shopping_cart;

    case 'livro':
      return Icons.book;

    case 'lampada':
      return Icons.lightbulb;
    
    case 'dinheiro':
      return Icons.money;
    
    case 'casa':
      return Icons.house;
    
    case 'maleta':
      return Icons.work;
    
    case 'veiculo':
      return Icons.fire_truck;

    case 'aviao':
      return Icons.airplanemode_active;

    case 'prato':
      return Icons.restaurant;

    case 'televisao':
      return Icons.tv;
    
    case 'geral':
      return Icons.list;

    default:
      return Icons.folder;
  }
}

  String formatarData(String data) {
    final dataConvertida = DateTime.parse(data).toLocal();

    return '${dataConvertida.day.toString().padLeft(2, '0')}/'
        '${dataConvertida.month.toString().padLeft(2, '0')}/'
        '${dataConvertida.year}';
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true, 

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: isSearchClicked
            ? Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value){
                    setState((){

                      searchQuery = value;
                    }

                    );
                  },
                  decoration: InputDecoration(
                    hintText: 'Pesquisar...',
                    hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                )
            )
            : const Text('Memora'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearchClicked = !isSearchClicked;
                if (!isSearchClicked) {
                  _searchController.clear();
                 
                }
              });
            },
            icon: Icon(
              isSearchClicked ? Icons.close : Icons.search,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              size: 30,
            ),
          ),

          IconButton(
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => TelaConfiguracoes(temaSelecionado: widget.temaSelecionado, aoMudarTema: widget.aoMudarTema)));
            },

            color: Theme.of(context).textTheme.bodyLarge?.color,

            icon: Icon(
              Icons.settings,
            ),
          ),
        ],

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            height: 1.0,
          ),
        ),
      ),

      body: Stack(
            children: [

              Positioned.fill(
                child: Image.asset( 
                  isDarkMode ? 'imagens/Fundo_escuro.png' : 'imagens/Fundo_claro.png',
                  fit: BoxFit.cover,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 125),

                child: SizedBox(
                  width: double.infinity,

                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),

                    child: SingleChildScrollView(
                      
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            "O que você precisa lembrar?",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          SizedBox(
                            width: double.infinity,
                          
                            child: OutlinedButton(
                              onPressed: () async {
                                await Navigator.push(context, MaterialPageRoute(builder: (context) => TelaRegistro(temaSelecionado: widget.temaSelecionado, aoMudarTema: widget.aoMudarTema)));

                                await carregarMemorias();
                              },

                              style: OutlinedButton.styleFrom(
                                foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
                                alignment: Alignment.centerLeft,
                                side: BorderSide(
                                  color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                                  width: 1.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                              child: Text(
                                "✨ Conte algo para o Memora",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 30,
                          ),


                          Center(
                            child: Text(
                              "Categorias",
                              style: TextStyle(
                                fontSize: 25,
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 30,
                          ),

                          if(categoriasPadroes.length >= 6) ...[
                            Row(
                            
                              children: [ 
                                Expanded(
                                  child: categoriaBotao(categoriasPadroes[5]),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: categoriaBotao(categoriasPadroes[4]),
                                ),
                              ],
                            ),

                            SizedBox(height: 10),

                            Row(

                              children: [
                                Expanded(
                                  child: categoriaBotao(categoriasPadroes[3]),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: categoriaBotao(categoriasPadroes[2]),
                                ),
                              ],
                            ),

                            SizedBox(height: 10),

                            Row(

                              children: [
                                Expanded(
                                  child: categoriaBotao(categoriasPadroes[1]),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: categoriaBotao(categoriasPadroes[0]),
                                ),
                              ],
                            ),
                          ],

                          SizedBox(
                            height: 15,
                          ),

                          Center(

                            child: OutlinedButton(
                              onPressed: () async {

                              },

                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                              ),

                              child: Text(
                                "Ver todas",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).textTheme.bodyLarge?.color,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 15,
                          ),

                          Text(
                            "Recentes",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                          ),

                          SizedBox(
                            height: 5,
                          ),

                          if (memorias.isEmpty) ...[
                            Text(
                              "Ainda não há registros.",
                              style: TextStyle(
                                fontSize: 24,
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                            Text(
                              "Comece guardando alguma coisa.",
                              style: TextStyle(
                                fontSize: 24,
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                          ],

                          if (memorias.isNotEmpty)
                            ...memorias.map(
                              (memoria) {
                                final categoria = memoria['categories'];

                                return SizedBox(
                                  width: double.infinity,
                                  height: 70,
                                  child: OutlinedButton(
                                    onPressed: () async {
                                      await Navigator.push(context, MaterialPageRoute(builder: (context) => TelaRegistro(temaSelecionado: widget.temaSelecionado, aoMudarTema: widget.aoMudarTema, memoryId: memoria['id'])));

                                      await carregarMemorias();
                                    },

                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,

                                          children: [

                                            Icon(
                                              getCategoryIcon(categoria['icon']),
                                              size: 25,
                                            ),

                                            SizedBox(
                                              width: 12,
                                            ),

                                            Text(
                                              memoria['content'],
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${categoria['name']} · ${formatarData(memoria['updated_at'])}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            ),

                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: SafeArea(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: OutlinedButton(
                                          onPressed: () async {
                                            await Navigator.push(context, MaterialPageRoute(builder: (context) => TelaRegistro(temaSelecionado: widget.temaSelecionado, aoMudarTema: widget.aoMudarTema)));

                                            await carregarMemorias();
                                          },

                                          style: OutlinedButton.styleFrom(
                                            iconColor: Theme.of(context).textTheme.bodyLarge?.color,
                                            iconSize: 50,
                                            shape: CircleBorder(),
                                          ),

                                          child: Icon(Icons.add),
                                        ),
                                      ),

                                      Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [

                                            Icon(
                                              Icons.home,
                                              size: 25,
                                              color: Colors.blue,
                                            ),

                                            SizedBox(
                                              width: 5,
                                            ),

                                            Text(
                                              "Início",
                                              style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            SizedBox(
                                              width: 10,
                                            ),

                                            Text(
                                              "|",
                                              style: TextStyle(
                                                fontSize: 25,
                                                color: Theme.of(context).textTheme.bodyLarge?.color,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            SizedBox(
                                              width: 2,
                                            ),

                                            TextButton.icon(
                                              onPressed: () async {
                                                // Navigator.push(context, MaterialPageRoute(builder: (context) => TelaTodosRegistros()));
                                              },

                                              style: TextButton.styleFrom(
                                                foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
                                                iconSize: 25,
                                                iconColor: Theme.of(context).textTheme.bodyLarge?.color,
                                              ),

                                              icon: Icon(Icons.assignment),
                                              label: Text(
                                                "Registros",
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context).textTheme.bodyLarge?.color,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                    ],
                                  ),
                                ),
                              ),
                    ],
                  ),
                ),

              ),
            ),
          ),
        ],
      ),
    );
  }
}