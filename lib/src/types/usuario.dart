class Usuario {
  int id;
  String login;
  String nome;
  String senha;
  String email; 
  String genero; 
  String tipo; 
  DateTime? dataNascimento; 

  Usuario({
    required this.id,
    required this.login,
    required this.nome,
    required this.senha,
    required this.email,
    required this.genero,
    required this.tipo,
    this.dataNascimento,
  });
}
