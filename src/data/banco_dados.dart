import '../types/servico.dart';
import '../types/usuario.dart';

class BancoDados{
  List<Usuario> listaUsuarios = [];
  List<Servico> listaServicos = [];

  BancoDados();

  armazenaServico(Servico servico){
    listaServicos.add(servico);
  }

  buscaServicos(){
    return listaServicos;
  }

  buscaServico(String id){
    return listaServicos.firstWhere((servico) => servico.id == id, orElse: () => throw Error());
  }

  alteraServico(String id, Servico novoServico){
    var antigoServico = listaServicos.firstWhere((servico) => servico.id == id, orElse: () => throw Error());
    antigoServico = novoServico;
    return antigoServico;
  }

  deletaServico(String id){
    var servico = buscaServico(id);
    listaServicos.remove(servico);

  }

  armazenaUsuario(Usuario usuario){
    listaUsuarios.add(usuario);
  }

  buscaUsuarios(){
    return listaUsuarios;
  }

  buscaUsuario(String id){
    return listaUsuarios.firstWhere((usuario) => usuario.id == id, orElse: () => throw Error());
  }

  alteraUsuario(String id, Usuario novoUsuario){
    var antigoUsuario = listaUsuarios.firstWhere((usuario) => usuario.id == id, orElse: () => throw Error());
    antigoUsuario = novoUsuario;
    return antigoUsuario;
  }

  deletaUsuario(String id){
    var usuario = buscaUsuario(id);
    listaUsuarios.remove(usuario);
  }

}