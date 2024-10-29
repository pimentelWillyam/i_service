import 'package:flutter/material.dart';
import '../data/banco_dados.dart';
import '../types/servico.dart';

class RegisterServiceView extends StatefulWidget {
  final BancoDados bancoDados;
  final VoidCallback onServiceAdded; 

  const RegisterServiceView({super.key, required this.bancoDados, required this.onServiceAdded});

  @override
  State<RegisterServiceView> createState() => _RegisterServiceViewState();
}

class _RegisterServiceViewState extends State<RegisterServiceView> {
  final _formKey = GlobalKey<FormState>();
  String _serviceName = '';
  String _serviceDescription = '';
  double _servicePrice = 0.0;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final novoServico = Servico(
        id: widget.bancoDados.listaServicos.length,
        idCadastrador: widget.bancoDados.usuarioEmSessao?.id ?? -1,
        nome: _serviceName,
        descricao: _serviceDescription,
        preco: _servicePrice,
      );

      widget.bancoDados.armazenaServico(novoServico);
      widget.onServiceAdded(); 
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Serviço'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome do Serviço'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do serviço';
                  }
                  return null;
                },
                onChanged: (value) {
                  _serviceName = value;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição do serviço';
                  }
                  return null;
                },
                onChanged: (value) {
                  _serviceDescription = value;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o preço';
                  }
                  return null;
                },
                onChanged: (value) {
                  _servicePrice = double.tryParse(value) ?? 0.0;
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
