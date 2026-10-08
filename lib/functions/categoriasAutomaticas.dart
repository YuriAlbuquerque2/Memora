import 'package:flutter/material.dart';
import 'package:memora/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoriasAutomaticas {

  static Future<void> criarCategoriasPadroes(String userId) async {
    final supabase = Supabase.instance.client;

    final compras = await supabase
    .from('categories')
    .insert({
      'name': 'Compras',
      'user_id': userId,
      'icon': 'carrinho_de_compras',
      'show_on_home': true,
      'home_position': 1,
    })
    .select('id, name')
    .single();

    final ideias = await supabase
    .from('categories')
    .insert({
      'name': 'Ideias',
      'user_id': userId,
      'icon': 'lampada',
      'show_on_home': true,
      'home_position': 2,
    })
    .select('id, name')
    .single();

    final estudos = await supabase
    .from('categories')
    .insert({
      'name': 'Estudos',
      'user_id': userId,
      'icon': 'livro',
      'show_on_home': true,
      'home_position': 3,
    })
    .select('id, name')
    .single();

    final saude = await supabase
    .from('categories')
    .insert({
      'name': 'Saúde',
      'user_id': userId,
      'icon': 'saude',
      'show_on_home': true,
      'home_position': 4,
    })
    .select('id, name')
    .single();

    final financas = await supabase
    .from('categories')
    .insert({
      'name': 'Finanças',
      'user_id': userId,
      'icon': 'dinheiro',
      'show_on_home': true,
      'home_position': 5,
    })
    .select('id, name')
    .single();

    final casa = await supabase
    .from('categories')
    .insert({
      'name': 'Casa',
      'user_id': userId,
      'icon': 'casa',
      'show_on_home': true,
      'home_position': 6,
    })
    .select('id, name')
    .single();

    final trabalho = await supabase
    .from('categories')
    .insert({
      'name': 'Trabalho',
      'user_id': userId,
      'icon': 'maleta',
    })
    .select('id, name')
    .single();

    final transporte = await supabase
    .from('categories')
    .insert({
      'name': 'Transporte',
      'user_id': userId,
      'icon': 'veiculo',
    })
    .select('id, name')
    .single();

    final viagens = await supabase
    .from('categories')
    .insert({
      'name': 'Viagens',
      'user_id': userId,
      'icon': 'aviao',
    })
    .select('id, name')
    .single();

    final alimentacao = await supabase
    .from('categories')
    .insert({
      'name': 'Alimentação',
      'user_id': userId,
      'icon': 'prato',
    })
    .select('id, name')
    .single();

    final tecnologia = await supabase
    .from('categories')
    .insert({
      'name': 'Tecnologia',
      'user_id': userId,
      'icon': 'televisao',
    })
    .select('id, name')
    .single();

    final geral = await supabase
    .from('categories')
    .insert({
      'name': 'Geral',
      'user_id': userId,
      'icon': 'geral',
    })
    .select('id, name')
    .single();

    final comprasId = compras['id'];
    final ideiasId = ideias['id'];
    final estudosId = estudos['id'];
    final saudeId = saude['id'];
    final financasId = financas['id'];
    final casaId = casa['id'];
    final trabalhoId = trabalho['id'];
    final transporteId = transporte['id'];
    final viagensId = viagens['id'];
    final alimentacaoId = alimentacao['id'];
    final tecnologiaId = tecnologia['id'];
    final geralId = geral['id'];

    final comprasTipos = await supabase.from('information_types').insert([
      {
        'category_id': comprasId,
        'name': 'Produto',
      },
      {
        'category_id': comprasId,
        'name': 'Lista de compras',
      },
      {
        'category_id': comprasId,
        'name': 'Compra realizada',
      }
      ])
      .select('id, name');

      final ideiasTipos = await supabase.from('information_types').insert([
      {
        'category_id': ideiasId,
        'name': 'Ideias de projeto',
      },
      {
        'category_id': ideiasId,
        'name': 'Ideia de conteúdo',
      },
      {
        'category_id': ideiasId,
        'name': 'Ideia geral',
      }
      ])
      .select('id, name');

      final estudosTipos = await supabase.from('information_types').insert([
      {
        'category_id': estudosId,
        'name': 'Disciplina',
      },
      {
        'category_id': estudosId,
        'name': 'Tarefa',
      },
      {
        'category_id': estudosId,
        'name': 'Prova',
      }
      ])
      .select('id, name');

      final saudeTipos = await supabase.from('information_types').insert([
      {
        'category_id': saudeId,
        'name': 'Consulta',
      },
      {
        'category_id': saudeId,
        'name': 'Exame',
      },
      {
        'category_id': saudeId,
        'name': 'Medicamento',
      }
      ])
      .select('id, name');

      final financasTipos = await supabase.from('information_types').insert([
      {
        'category_id': financasId,
        'name': 'Despesa',
      },
      {
        'category_id': financasId,
        'name': 'Receita',
      },
      {
        'category_id': financasId,
        'name': 'Pagamento',
      }
      ])
      .select('id, name');

      final casaTipos = await supabase.from('information_types').insert([
      {
        'category_id': casaId,
        'name': 'Tarefa doméstica',
      },
      {
        'category_id': casaId,
        'name': 'Manutenção',
      },
      {
        'category_id': casaId,
        'name': 'Item da casa',
      }
      ])
      .select('id, name');

      final trabalhoTipos = await supabase.from('information_types').insert([
      {
        'category_id': trabalhoId,
        'name': 'Tarefa',
      },
      {
        'category_id': trabalhoId,
        'name': 'Reunião',
      },
      {
        'category_id': trabalhoId,
        'name': 'Projeto',
      }
      ])
      .select('id, name');

      final transporteTipos = await supabase.from('information_types').insert([
      {
        'category_id': transporteId,
        'name': 'Veículo',
      },
      {
        'category_id': transporteId,
        'name': 'Manutenção',
      },
      {
        'category_id': transporteId,
        'name': 'Transporte público',
      }
      ])
      .select('id, name');

      final viagensTipos = await supabase.from('information_types').insert([
      {
        'category_id': viagensId,
        'name': 'Viagem',
      },
      {
        'category_id': viagensId,
        'name': 'Reserva',
      },
      {
        'category_id': viagensId,
        'name': 'Roteiro',
      }
      ])
      .select('id, name');
      

      final alimentacaoTipos = await supabase.from('information_types').insert([
      {
        'category_id': alimentacaoId,
        'name': 'Refeição',
      },
      {
        'category_id': alimentacaoId,
        'name': 'Receita',
      },
      {
        'category_id': alimentacaoId,
        'name': 'Restaurante',
      }
      ])
      .select('id, name');

      final tecnologiaTipos = await supabase.from('information_types').insert([
      {
        'category_id': tecnologiaId,
        'name': 'Equipamento',
      },
      {
        'category_id': tecnologiaId,
        'name': 'Software',
      },
      {
        'category_id': tecnologiaId,
        'name': 'Problema técnico',
      }
      ])
      .select('id, name');

      final produtoId = comprasTipos
      .firstWhere((tipo) => tipo['name'] == 'Produto')['id'];
      final listaDeComprasId = comprasTipos
      .firstWhere((tipo) => tipo['name'] == 'Lista de compras')['id'];
      final compraRealizadaId = comprasTipos
      .firstWhere((tipo) => tipo['name'] == 'Compra realizada')['id'];

      final ideiasDeprojetoId = ideiasTipos
      .firstWhere((tipo) => tipo['name'] == 'Ideias de projeto')['id'];
      final ideiaDeConteudoId = ideiasTipos
      .firstWhere((tipo) => tipo['name'] == 'Ideia de conteúdo')['id'];
      final ideiaGeralId = ideiasTipos
      .firstWhere((tipo) => tipo['name'] == 'Ideia geral')['id'];

      final disciplinaId = estudosTipos
      .firstWhere((tipo) => tipo['name'] == 'Disciplina')['id'];
      final eTarefaId = estudosTipos
      .firstWhere((tipo) => tipo['name'] == 'Tarefa')['id'];
      final provaId = estudosTipos
      .firstWhere((tipo) => tipo['name'] == 'Prova')['id'];

      final consultaId = saudeTipos
      .firstWhere((tipo) => tipo['name'] == 'Consulta')['id'];
      final exameId = saudeTipos
      .firstWhere((tipo) => tipo['name'] == 'Exame')['id'];
      final medicamentoId = saudeTipos
      .firstWhere((tipo) => tipo['name'] == 'Medicamento')['id'];

      final despesaId = financasTipos
      .firstWhere((tipo) => tipo['name'] == 'Despesa')['id'];
      final fReceitaId = financasTipos
      .firstWhere((tipo) => tipo['name'] == 'Receita')['id'];
      final pagamentoId = financasTipos
      .firstWhere((tipo) => tipo['name'] == 'Pagamento')['id'];

      final tarefaDomesticaId = casaTipos
      .firstWhere((tipo) => tipo['name'] == 'Tarefa doméstica')['id'];
      final cManutencaoId = casaTipos
      .firstWhere((tipo) => tipo['name'] == 'Manutenção')['id'];
      final itemDaCasaId = casaTipos
      .firstWhere((tipo) => tipo['name'] == 'Item da casa')['id'];

      final tTarefaId = trabalhoTipos
      .firstWhere((tipo) => tipo['name'] == 'Tarefa')['id'];
      final reuniaoId = trabalhoTipos
      .firstWhere((tipo) => tipo['name'] == 'Reunião')['id'];
      final projetoId = trabalhoTipos
      .firstWhere((tipo) => tipo['name'] == 'Projeto')['id'];

      final veiculoId = transporteTipos
      .firstWhere((tipo) => tipo['name'] == 'Veículo')['id'];
      final tManutencaoId = transporteTipos
      .firstWhere((tipo) => tipo['name'] == 'Manutenção')['id'];
      final transportePublicoId = transporteTipos
      .firstWhere((tipo) => tipo['name'] == 'Transporte público')['id'];

      final viagemId = viagensTipos
      .firstWhere((tipo) => tipo['name'] == 'Viagem')['id'];
      final reservaId = viagensTipos
      .firstWhere((tipo) => tipo['name'] == 'Reserva')['id'];
      final roteiroId = viagensTipos
      .firstWhere((tipo) => tipo['name'] == 'Roteiro')['id'];

      final refeicaoId = alimentacaoTipos
      .firstWhere((tipo) => tipo['name'] == 'Refeição')['id'];
      final aReceitaId = alimentacaoTipos
      .firstWhere((tipo) => tipo['name'] == 'Receita')['id'];
      final restauranteId = alimentacaoTipos
      .firstWhere((tipo) => tipo['name'] == 'Restaurante')['id'];

      final equipamentoId = tecnologiaTipos
      .firstWhere((tipo) => tipo['name'] == 'Equipamento')['id'];
      final softwareId = tecnologiaTipos
      .firstWhere((tipo) => tipo['name'] == 'Software')['id'];
      final problemaTecnicoId = tecnologiaTipos
      .firstWhere((tipo) => tipo['name'] == 'Problema técnico')['id'];

      await supabase.from('fields').insert([
        {
          'type_id': produtoId,
          'name': 'Nome do produto',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': produtoId,
          'name': 'Quantidade',
          'field_type': 'numeric',
          'required': false,
        },
        {
          'type_id': produtoId,
          'name': 'Preço',
          'field_type': 'numeric',
          'required': false,
        },
        {
          'type_id': produtoId,
          'name': 'Loja',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': listaDeComprasId,
          'name': 'Nome da lista',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': listaDeComprasId,
          'name': 'Itens',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': listaDeComprasId,
          'name': 'Data desejada',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': compraRealizadaId,
          'name': 'Produto',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': compraRealizadaId,
          'name': 'Valor',
          'field_type': 'numeric',
          'required': false,
        },
        {
          'type_id': compraRealizadaId,
          'name': 'Loja',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': compraRealizadaId,
          'name': 'Data da compra',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': ideiasDeprojetoId,
          'name': 'Nome',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': ideiasDeprojetoId,
          'name': 'Descrição',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': ideiasDeprojetoId,
          'name': 'Prioridade',
          'field_type': 'text',
          'required': false,
        },
        {
        'type_id': ideiasDeprojetoId,
          'name': 'Data prevista',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': ideiaDeConteudoId,
          'name': 'Título',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': ideiaDeConteudoId,
          'name': 'Descrição',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': ideiaDeConteudoId,
          'name': 'Plataforma',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': ideiaGeralId,
          'name': 'Título',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': ideiaGeralId,
          'name': 'Descrição',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': ideiaGeralId,
          'name': 'Observações',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': disciplinaId,
          'name': 'Nome',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': disciplinaId,
          'name': 'Professor',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': disciplinaId,
          'name': 'Instituição',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': disciplinaId,
          'name': 'Semestre',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': eTarefaId,
          'name': 'Descrição',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': eTarefaId,
          'name': 'Disciplina',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': eTarefaId,
          'name': 'Prazo',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': eTarefaId,
          'name': 'Prioridade',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': provaId,
          'name': 'Disciplina',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': provaId,
          'name': 'Data',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': provaId,
          'name': 'Horário',
          'field_type': 'time',
          'required': false,
        },
        {
          'type_id': provaId,
          'name': 'Local',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': consultaId,
          'name': 'Médico',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': consultaId,
          'name': 'Especialidade',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': consultaId,
          'name': 'Data',
          'field_type': 'date',
          'required': false, 
        },
        {
          'type_id': consultaId,
          'name': 'Horário',
          'field_type': 'time',
          'required': false,
        },
        {
          'type_id': consultaId,
          'name': 'Local',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': exameId,
          'name': 'Nome do exame',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': exameId,
          'name': 'Data',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': exameId,
          'name': 'Laboratório',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': exameId,
          'name': 'Resultado',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': medicamentoId,
          'name': 'Nome',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': medicamentoId,
          'name': 'Dosagem',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': medicamentoId,
          'name': 'Frequência',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': medicamentoId,
          'name': 'Data de início',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': despesaId,
          'name': 'Descrição',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': despesaId,
          'name': 'Valor',
          'field_type': 'numeric',
          'required': false,
        },
        {
          'type_id': despesaId,
          'name': 'Data',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': despesaId,
          'name': 'Categoria de despesa',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': fReceitaId,
          'name': 'Descrição',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': fReceitaId,
          'name': 'Valor',
          'field_type': 'numeric',
          'required': false,
        },
        {
          'type_id': fReceitaId,
          'name': 'Data',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': fReceitaId,
          'name': 'Fonte',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': pagamentoId,
          'name': 'Descrição',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': pagamentoId,
          'name': 'Valor',
          'field_type': 'numeric',
          'required': false,
        },
        {
          'type_id': pagamentoId,
          'name': 'Vencimento',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': pagamentoId,
          'name': 'Forma de pagamento',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': tarefaDomesticaId,
          'name': 'Descrição',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': tarefaDomesticaId,
          'name': 'Responsável',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': tarefaDomesticaId,
          'name': 'Data',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': tarefaDomesticaId,
          'name': 'Prioridade',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': cManutencaoId,
          'name': 'Descrição',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': cManutencaoId,
          'name': 'Local',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': cManutencaoId,
          'name': 'Data',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': cManutencaoId,
          'name': 'Profissional',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': cManutencaoId,
          'name': 'Valor',
          'field_type': 'numeric',
          'required': false,
        },
        {
          'type_id': itemDaCasaId,
          'name': 'Nome',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': itemDaCasaId,
          'name': 'Local',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': itemDaCasaId,
          'name': 'Quantidade',
          'field_type': 'numeric',
          'required': false,
        },
        {
          'type_id': tTarefaId,
          'name': 'Descrição',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': tTarefaId,
          'name': 'Projeto',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': tTarefaId,
          'name': 'Prazo',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': tTarefaId,
          'name': 'Prioridade',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': reuniaoId,
          'name': 'Assunto',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': reuniaoId,
          'name': 'Data',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': reuniaoId,
          'name': 'Horário',
          'field_type': 'time',
          'required': false,
        },
        {
          'type_id': reuniaoId,
          'name': 'Local',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': reuniaoId,
          'name': 'Participantes',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': projetoId,
          'name': 'Nome',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': projetoId,
          'name': 'Descrição',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': projetoId,
          'name': 'Responsável',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': projetoId,
          'name': 'Prazo',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': veiculoId,
          'name': 'Modelo',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': veiculoId,
          'name': 'Placa',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': veiculoId,
          'name': 'Ano',
          'field_type': 'numeric',
          'required': false,
        },
        {
          'type_id': veiculoId,
          'name': 'Quilometragem',
          'field_type': 'numeric',
          'required': false,
        },
        {
          'type_id': tManutencaoId,
          'name': 'Veículo',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': tManutencaoId,
          'name': 'Serviço',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': tManutencaoId,
          'name': 'Data',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': tManutencaoId,
          'name': 'Valor',
          'field_type': 'numeric',
          'required': false,
        },
        {
          'type_id': transportePublicoId,
          'name': 'Tipo',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': transportePublicoId,
          'name': 'Linha',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': transportePublicoId,
          'name': 'Valor',
          'field_type': 'numeric',
          'required': false,
        },
        {
          'type_id': viagemId,
          'name': 'Destino',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': viagemId,
          'name': 'Data de ida',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': viagemId,
          'name': 'Data de volta',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': viagemId,
          'name': 'Local de hospedagem',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': reservaId,
          'name': 'Tipo',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': reservaId,
          'name': 'Local',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': reservaId,
          'name': 'Data de entrada',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': reservaId,
          'name': 'Data de saída',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': reservaId,
          'name': 'Código da reserva',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': roteiroId,
          'name': 'Local',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': roteiroId,
          'name': 'Data',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': roteiroId,
          'name': 'Horário',
          'field_type': 'time',
          'required': false,
        },
        {
          'type_id': roteiroId,
          'name': 'Observações',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': refeicaoId,
          'name': 'Nome',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': refeicaoId,
          'name': 'Data',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': refeicaoId,
          'name': 'Horário',
          'field_type': 'time',
          'required': false,
        },
        {
          'type_id': refeicaoId,
          'name': 'Local',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': aReceitaId,
          'name': 'Nome',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': aReceitaId,
          'name': 'Ingredientes',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': aReceitaId,
          'name': 'Tempo de preparo',
          'field_type': 'numeric',
          'required': false,
        },
        {
          'type_id': aReceitaId,
          'name': 'Observações',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': restauranteId,
          'name': 'Nome',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': restauranteId,
          'name': 'Endereço',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': restauranteId,
          'name': 'Telefone',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': restauranteId,
          'name': 'Avaliação',
          'field_type': 'numeric',
          'required': false,
        },
        {
          'type_id': equipamentoId,
          'name': 'Nome',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': equipamentoId,
          'name': 'Marca',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': equipamentoId,
          'name': 'Modelo',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': equipamentoId,
          'name': 'Número de série',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': softwareId,
          'name': 'Nome',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': softwareId,
          'name': 'Versão',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': softwareId,
          'name': 'Licença',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': softwareId,
          'name': 'Data de instalação',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': problemaTecnicoId,
          'name': 'Descrição',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': problemaTecnicoId,
          'name': 'Equipamento',
          'field_type': 'text',
          'required': false,
        },
        {
          'type_id': problemaTecnicoId,
          'name': 'Data',
          'field_type': 'date',
          'required': false,
        },
        {
          'type_id': problemaTecnicoId,
          'name': 'Solução',
          'field_type': 'text',
          'required': false,
        },
      ]);
}

  static Future<List<Map<String, dynamic>>> lerCategoriasPadroes(String userId) async {
    final supabase = Supabase.instance.client;

    final response = await supabase
    .from('categories')
    .select('name, icon, home_position')
    .eq('user_id', userId)
    .eq('show_on_home', true)
    .order('home_position');
    
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<List<Map<String, dynamic>>> lerTodasCategorias(String userId) async {
    final response = await supabase
    .from('categories')
    .select('id, name')
    .eq('user_id', userId)
    .order('name');

    return List<Map<String, dynamic>>.from(response);
  }
}

