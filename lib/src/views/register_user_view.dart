import 'package:flutter/material.dart';
import '../data/banco_dados.dart';
import '../types/usuario.dart'; 

class RegisterUserView extends StatefulWidget {
  final BancoDados bancoDados;

  const RegisterUserView({super.key, required this.bancoDados});

  @override
  State<RegisterUserView> createState() => _RegisterUserViewState();
}

class _RegisterUserViewState extends State<RegisterUserView> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _email = '';
  String _name = ''; 
  String _gender = 'Masculino'; 
  String _userType = 'Cliente'; 
  DateTime? _birthDate;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final novoUsuario = Usuario(
        id: widget.bancoDados.listaUsuarios.length,
        login: _username,
        senha: _password,
        email: _email,
        genero: _gender,
        tipo: _userType,
        dataNascimento: _birthDate,
        nome: _name, 
      );

      widget.bancoDados.armazenaUsuario(novoUsuario);
      print(widget.bancoDados.listaUsuarios.length);
      Navigator.pop(context);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _birthDate) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  String? _formatDate(DateTime? date) {
    if (date == null) return 'Select your birth date';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
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
                  labelText: 'Nome', 
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira seu nome'; 
                  }
                  return null;
                },
                onChanged: (value) {
                  _name = value; 
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome de usuário',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira seu nome de usuário';
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
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira o seu e-mail';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Por favor insira um e-mail válido';
                  }
                  return null;
                },
                onChanged: (value) {
                  _email = value;
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: const InputDecoration(
                  labelText: 'Gênero',
                ),
                items: <String>['Masculino', 'Feminino', 'Outro']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _gender = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _userType,
                decoration: const InputDecoration(
                  labelText: 'Tipo de Usuário',
                ),
                items: <String>['Cliente', 'Prestador de Serviços']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _userType = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Data do Nascimento',
                  hintText: _formatDate(_birthDate),
                ),
                onTap: () => _selectDate(context),
                validator: (value) {
                  if (_birthDate == null) {
                    return 'Por favor insira a sua data de nascimento';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
