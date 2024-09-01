import '../data/banco_dados.dart';
import '../types/usuario.dart';

class CadastraUsuario{
  execute(BancoDados bancoDados, Usuario usuario){
    bancoDados.armazenaUsuario(usuario);
  }
}