import 'package:flutter/material.dart';
import '../data/banco_dados.dart';
import '../types/servico.dart';

class ClientServicesListView extends StatefulWidget {
  final BancoDados bancoDados;

  const ClientServicesListView({super.key, required this.bancoDados});

  @override
  State<ClientServicesListView> createState() => _ClientServicesListViewState();
}

class _ClientServicesListViewState extends State<ClientServicesListView> {
  void _showDetails(Servico servico) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemDetailPage(servico: servico, bancoDados: widget.bancoDados),
      ),
    );

    if (resultado == true) {
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Serviços'),
      ),
      body: ListView.builder(
        itemCount: widget.bancoDados.listaServicos.length,
        itemBuilder: (context, index) {
          final servico = widget.bancoDados.listaServicos[index];
          return ListTile(
            title: Text(servico.nome),
            onTap: () => _showDetails(servico),
          );
        },
      ),
    );
  }
}

class ItemDetailPage extends StatelessWidget {
  final Servico servico;
  final BancoDados bancoDados;

  const ItemDetailPage({super.key, required this.servico, required this.bancoDados});

  void _contratarServico(BuildContext context) {
    bancoDados.deletaServico(servico.id);
    
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(servico.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome: ${servico.nome}\nDescrição: ${servico.descricao}\nPreço: ${servico.preco}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => _contratarServico(context),
                child: const Text("Contratar Serviço"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
