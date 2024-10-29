import 'package:flutter/material.dart';
import '../data/banco_dados.dart';

class LoginView extends StatefulWidget {
  final BancoDados bancoDados;

  const LoginView({super.key, required this.bancoDados});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      var usuarioEncontrado = widget.bancoDados.listaUsuarios.firstWhere(
      (usuario) => usuario.login == _username && usuario.senha == _password,
      orElse: () => throw Exception("Nenhum usuário encontrado com o login e senha fornecidos."));
      switch (usuarioEncontrado.tipo) {
        case 'Cliente':
          widget.bancoDados.armazenaUsuarioEmSessao(usuarioEncontrado);
          Navigator.pushNamed(context,'/client_services', arguments: widget.bancoDados);
          break;

        case 'Prestador de Serviços':
          widget.bancoDados.armazenaUsuarioEmSessao(usuarioEncontrado);
          Navigator.pushNamed(context,'/provider_services', arguments: widget.bancoDados);
          break;
        default:
          throw Exception("Nenhum usuário encontrado com o login e senha fornecidos.");
      }
    }
  }

  void _register() {
    Navigator.pushNamed(
      context,
      '/register_user',
      arguments: widget.bancoDados,
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Usuário',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira seu usuário';
                  }
                  return null;
                },
                onChanged: (value) {
                  _username = value;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira sua senha';
                  }
                  return null;
                },
                onChanged: (value) {
                  _password = value;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: _register,
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
