import '../enums/tipo_usuario.dart';

class Usuario{
    String id;
    String login;
    String nome;
    String senha;
    TipoUsuario tipo;

    Usuario(this.id, this.login, this.nome, this.senha, this.tipo);


}