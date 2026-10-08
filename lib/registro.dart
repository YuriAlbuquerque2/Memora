import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:memora/main.dart';
import 'package:memora/functions/categoriasAutomaticas.dart';

class TelaRegistro extends StatefulWidget {
  final ThemeMode temaSelecionado;
  final Function(ThemeMode) aoMudarTema;
  final String? memoryId;

  const TelaRegistro({super.key, required this.temaSelecionado, required this.aoMudarTema, this.memoryId});

  @override
  State<TelaRegistro> createState() => _TelaRegistro();
}

class _TelaRegistro extends State<TelaRegistro> {

  final FocusNode _focusNode = FocusNode();
  final TextEditingController contentController = TextEditingController();
  final Map<String, TextEditingController> fieldControllers = {};
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> categorias = [];
  String? categoriaSelecionada;
  List<Map<String, dynamic>> tipos = [];
  String? tipoSelecionado;
  List<Map<String, dynamic>> campos = [];
  DateTime? dataCriacao;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      carregarTodasCategorias();

      if (widget.memoryId != null) {
        await carregarRegistro(widget.memoryId!);
      } else {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    contentController.dispose();

    for (final controller in fieldControllers.values) {
      controller.dispose();
    }

    super.dispose();
  }

  Future<void> carregarRegistro(String memoryId) async {
    final userId = supabase.auth.currentUser?.id;

    if (userId == null) return;

    final memoria = await supabase
        .from('memories')
        .select('id, content, category_id, type_id, created_at')
        .eq('id', memoryId)
        .eq('user_id', userId)
        .single();

    final valoresCampos = await supabase
        .from('memory_fields')
        .select('field_id, value')
        .eq('memory_id', memoryId);

    contentController.text = memoria['content']?.toString() ?? '';

    dataCriacao = DateTime.parse(
      memoria['created_at'].toString(),
    ).toLocal();

    final categoryId = memoria['category_id']?.toString();
    final typeId = memoria['type_id']?.toString();

    if (categoryId == null) return;

    setState(() {
      categoriaSelecionada = categoryId;
    });

    await carregarTipos(categoryId);

    if (typeId == null) return;

    setState(() {
      tipoSelecionado = typeId;
    });

    await carregarCampos(typeId);

    for (final campo in valoresCampos) {
      final fieldId = campo['field_id'].toString();
      final value = campo['value'];

      if (fieldControllers.containsKey(fieldId)) {
        fieldControllers[fieldId]!.text = value?.toString() ?? '';
      }
    }

    setState(() {});
  }

  Future<void> carregarTodasCategorias() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;

    if (userId == null) return;

    final categoriasCarregadas =
        await CategoriasAutomaticas.lerTodasCategorias(userId);

    if (!mounted) return;
    
    setState(() {
      categorias = categoriasCarregadas;
    });
  }

  Future<void> carregarTipos(String categoryId) async {
    final supabase = Supabase.instance.client;

    final response = await supabase
    .from('information_types')
    .select('id, name')
    .eq('category_id', categoryId)
    .order('name');

    setState(() {
      tipos = List<Map<String, dynamic>>.from(response);
    });
  }

  Future<void> carregarCampos(String typeId) async {
    final supabase = Supabase.instance.client;

    final response = await supabase
        .from('fields')
        .select('id, name, field_type, required')
        .eq('type_id', typeId)
        .order('name');

    final novosCampos = List<Map<String, dynamic>>.from(response);

    // Limpa os controllers anteriores
    for (final controller in fieldControllers.values) {
      controller.dispose();
    }

    fieldControllers.clear();

    // Cria um controller para cada novo campo
    for (final campo in novosCampos) {
      final fieldId = campo['id'].toString();

      fieldControllers[fieldId] = TextEditingController();
    }

    setState(() {
      campos = novosCampos;
    });
  }

  Future<void> selecionarData(String fieldId) async {
    final data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (data != null) {
      fieldControllers[fieldId]?.text =
          '${data.day.toString().padLeft(2, '0')}/'
          '${data.month.toString().padLeft(2, '0')}/'
          '${data.year}';
    }
  }

  Future<void> selecionarHorario(String fieldId) async {
    final horario = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (horario != null) {
      fieldControllers[fieldId]?.text =
          '${horario.hour.toString().padLeft(2, '0')}:'
          '${horario.minute.toString().padLeft(2, '0')}';
    }
  }

  String formatarData(String data) {
    final dataConvertida = DateTime.parse(data).toLocal();

    return '${dataConvertida.day.toString().padLeft(2, '0')}/'
        '${dataConvertida.month.toString().padLeft(2, '0')}/'
        '${dataConvertida.year}';
  }

  Future<void> confirmarExclusao() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Excluir registro',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          content: Text(
            'Tem certeza que deseja excluir este registro?',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(
                'Cancelar',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                'Excluir',
                style: const TextStyle(
                  color: Colors.red,
                ),
                ),
            ),
          ],
        );
      },
    );

    if (confirmar == true) {
      await excluirRegistro();
    }
  }

  Future<void> excluirRegistro() async {
    final userId = supabase.auth.currentUser?.id;

    if (userId == null || widget.memoryId == null) return;

    try {
      await supabase
          .from('memories')
          .delete()
          .eq('id', widget.memoryId!)
          .eq('user_id', userId);

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (error, stackTrace) {
      print('ERRO AO EXCLUIR: $error');
      print('STACK TRACE: $stackTrace');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final userId = supabase.auth.currentUser?.id;

    return Scaffold(
      extendBodyBehindAppBar: true, 

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.memoryId == null
          ? 'Novo registro'
          : 'Editar registro',
        ),
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
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (valor) {
              if (valor == 'adicionar lembrete') {

              }

              if (valor == 'excluir registro') {
                confirmarExclusao();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'adicionar lembrete',
                child: Text('Adicionar Lembrete'),
              ),

              if (widget.memoryId != null)
                const PopupMenuItem(
                  value: 'excluir registro',
                  child: Text('Excluir Registro'),
                ),
            ],
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

          Positioned.fill(
            child: Column(
              children: [

                SizedBox(
                  height: kToolbarHeight + MediaQuery.of(context).padding.top,
                ),

                SizedBox(
                  height: 300,
                  child: TextField(
                    controller: contentController,
                    focusNode: _focusNode,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),

                Divider(
                  height: 1,
                  thickness: 1,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),

                // SizedBox(height: 15),

                Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                        bottom: 0,
                      ),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.memoryId == null) ...[
                              Text(
                                "Memora identificou:",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).textTheme.bodyLarge?.color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],

                            if (widget.memoryId != null && dataCriacao != null) ...[
                              Text(
                                'Data de criação: ${formatarData(dataCriacao!.toIso8601String())}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).textTheme.bodyLarge?.color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],

                            SizedBox(height: 15),

                            DropdownButtonFormField(
                              initialValue: categoriaSelecionada,

                              decoration: InputDecoration(
                                labelText: 'Categoria',
                                border: OutlineInputBorder(),
                              ),

                              hint: Text('Selecione uma categoria'),

                              items: categorias.map((categoria) {
                                return DropdownMenuItem<String>(
                                  value: categoria['id'].toString(),
                                  child: Text(
                                    categoria['name'].toString(),
                                    style: TextStyle(
                                      color: Theme.of(context).textTheme.bodyLarge?.color,
                                    ),
                                  ),
                                );
                              }).toList(),

                              onChanged: (valor) async {
                                if (valor == null) return;

                                setState(() {
                                  categoriaSelecionada = valor;
                                  tipoSelecionado = null;
                                  tipos = [];
                                  campos = [];
                                });

                                await carregarTipos(valor);
                              },
                            ),

                            SizedBox(height: 15),

                            if (categoriaSelecionada != null)
                              DropdownButtonFormField(
                                initialValue: tipoSelecionado,

                                decoration: InputDecoration(
                                  labelText: 'Tipo',
                                  border: OutlineInputBorder(),
                                ),

                                hint: Text("Selecione um tipo"),

                                items: tipos.map((tipo) {
                                  return DropdownMenuItem<String>(
                                    value: tipo['id'].toString(),
                                    child: Text(
                                      tipo['name'].toString(),
                                      style: TextStyle(
                                        color: Theme.of(context).textTheme.bodyLarge?.color,
                                      ),
                                    ),
                                  );
                                }).toList(),

                                onChanged: (valor) async {
                                  if (valor == null) return;

                                  setState(() {
                                    tipoSelecionado = valor;
                                    campos = [];
                                  });

                                  await carregarCampos(valor);
                                }
                              ),

                              SizedBox(height: 2,),

                              if (tipoSelecionado != null)
                                ...campos.map((campo) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${campo['name']}:',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.color,
                                          ),
                                        ),

                                        const SizedBox(width: 8),

                                        Expanded(
                                          child: TextField(
                                            controller: fieldControllers[campo['id'].toString()],
                                            maxLines: 1,

                                            readOnly: campo['field_type'] == 'date' ||
                                            campo['field_type'] == 'time',

                                            keyboardType: campo['field_type'] == 'numeric'
                                              ? TextInputType.number
                                              : TextInputType.text,

                                              onTap: () async {
                                                final fieldId = campo['id'].toString();

                                                if (campo['field_type'] == 'date') {
                                                  await selecionarData(fieldId);
                                                } else if (campo['field_type'] == 'time') {
                                                  await selecionarHorario(fieldId);
                                                }
                                              },

                                            decoration: const InputDecoration(
                                              hintText: 'Digite aqui',
                                              border: InputBorder.none,
                                              isDense: true,
                                              hintStyle: TextStyle(
                                                color: Color.fromARGB(255, 200, 200, 200),
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                            ],
                          ),
                        ],
                      ),
                  ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton(
                      onPressed: () async {
                        if (userId != null) {
                          try {
                            if (widget.memoryId == null) {
                              final memoria = await supabase
                              .from('memories')
                              .insert({
                                'user_id': userId,
                                'category_id': categoriaSelecionada,
                                'type_id': tipoSelecionado,
                                'content': contentController.text.trim(),
                              })
                              .select('id')
                              .single();

                              final memoryId = memoria['id'];

                              final valoresCampos = campos.map((campo) {
                                final fieldId = campo['id'].toString();

                                final texto = fieldControllers[fieldId]?.text.trim();

                                return {
                                  'memory_id': memoryId,
                                  'field_id': campo['id'],
                                  'value': texto?.isEmpty == true ? null : texto,
                                };
                              }).toList();

                              if (valoresCampos.isNotEmpty) {
                                await supabase
                                    .from('memory_fields')
                                    .insert(valoresCampos);
                              }
                            } else {
                              await supabase
                              .from('memories')
                              .update({
                                'category_id': categoriaSelecionada,
                                'type_id': tipoSelecionado,
                                'content': contentController.text.trim(),
                                'updated_at': DateTime.now().toUtc().toIso8601String(),
                              })
                              .eq('id', widget.memoryId!)
                              .eq('user_id', userId);

                              await supabase
                              .from('memory_fields')
                              .delete()
                              .eq('memory_id', widget.memoryId!);

                              final valoresCampos = campos.map((campo) {
                                final fieldId = campo['id'].toString();
                                final texto = fieldControllers[fieldId]?.text.trim();

                                return {
                                  'memory_id': widget.memoryId!,
                                  'field_id': campo['id'],
                                  'value': texto?.isEmpty == true ? null : texto,
                                  'updated_at': DateTime.now().toUtc().toIso8601String(),
                                };
                              }).toList();

                              if (valoresCampos.isNotEmpty) {
                                await supabase
                                .from('memory_fields')
                                .insert(valoresCampos);
                              }
                            }

                            Navigator.pop(context);
                          } catch (error) {
                            print('ERRO ERRADO: $error');
                            print('STACK TRACE: $StackTrace');
                            return;
                          }
                        }
                      },

                      style: OutlinedButton.styleFrom(
                        iconColor: Theme.of(context).textTheme.bodyLarge?.color,
                        iconSize: 50,
                        shape: CircleBorder(),
                      ),

                      child: Icon(Icons.check),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
}

