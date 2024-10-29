import '../data/banco_dados.dart';
import '../types/servico.dart';

class CadastraServico{
  execute(BancoDados bancoDados, Servico servico){
    bancoDados.armazenaServico(servico);
  }
}