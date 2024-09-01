import '../data/banco_dados.dart';
import '../types/servico.dart';

class BuscaServicos{
  execute(BancoDados bancoDados, Servico servico){
    bancoDados.buscaServicos();
  }
}