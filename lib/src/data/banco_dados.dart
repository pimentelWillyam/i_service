import 'package:i_service_4/src/types/servico.dart';
import 'package:i_service_4/src/types/usuario.dart';

class BancoDados {
  List<Usuario> listaUsuarios = [Usuario(
    id: 0, login: 'cliente', nome: 'cliente', senha: 'cliente', email: 'cliente@cliente.com', genero: "Masculino", tipo: "Cliente"),
    Usuario(
      id: 1, login: 'prestador', nome: 'prestador', senha: 'prestador', email: 'prestador@prestador.com', genero: "Masculino", tipo: "Prestador de Serviços")];

  List<Servico> listaServicos = [Servico(
    id: 0, idCadastrador: 1, nome: "Desentupir Pia", descricao: "Desentupimento completo de pia", preco: 155.5),
    Servico(id: 0, idCadastrador: 1, nome: "Faxina de quarto", descricao: "Faxina completa de um quarto ", preco: 96.3)];

  Usuario? usuarioEmSessao;

  BancoDados();

  void armazenaServico(Servico servico) {
    listaServicos.add(servico);
  }

  List<Servico> buscaServicos() {
    return listaServicos;
  }

  Servico buscaServico(int id) {
    return listaServicos.firstWhere((servico) => servico.id == id, orElse: () => throw Error());
  }

  Servico alteraServico(int id, Servico novoServico) {
    var antigoServico = buscaServico(id);
    antigoServico.nome = novoServico.nome;
    antigoServico.descricao = novoServico.descricao;
    antigoServico.preco = novoServico.preco;
    return antigoServico;
  }

  void deletaServico(int id) {
    var servico = buscaServico(id);
    listaServicos.remove(servico);
  }

  void armazenaUsuario(Usuario usuario) {
    listaUsuarios.add(usuario);
  }

  List<Usuario> buscaUsuarios() {
    return listaUsuarios;
  }

  Usuario buscaUsuario(String id) {
    return listaUsuarios.firstWhere((usuario) => usuario.id == id, orElse: () => throw Error());
  }

  Usuario alteraUsuario(String id, Usuario novoUsuario) {
    var antigoUsuario = buscaUsuario(id);
    antigoUsuario.login = novoUsuario.login;
    antigoUsuario.senha = novoUsuario.senha;
    antigoUsuario.email = novoUsuario.email;
    antigoUsuario.genero = novoUsuario.genero;
    antigoUsuario.tipo = novoUsuario.tipo;
    antigoUsuario.dataNascimento = novoUsuario.dataNascimento;
    return antigoUsuario;
  }

  void deletaUsuario(String id) {
    var usuario = buscaUsuario(id);
    listaUsuarios.remove(usuario);
  }

  void armazenaUsuarioEmSessao(Usuario usuario) {
    usuarioEmSessao = usuario;
  }

  Usuario? buscaUsuarioEmSessao() {
    return usuarioEmSessao;
  }
}
