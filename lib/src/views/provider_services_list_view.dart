import 'package:flutter/material.dart';
import '../data/banco_dados.dart';
import '../types/servico.dart';
import 'register_service_view.dart'; 

class ProviderServicesListView extends StatefulWidget {
  final BancoDados bancoDados;

  const ProviderServicesListView({super.key, required this.bancoDados});

  @override
  State<ProviderServicesListView> createState() => _ProviderServicesListViewState();
}

class _ProviderServicesListViewState extends State<ProviderServicesListView> {
  void _addItem() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterServiceView(
          bancoDados: widget.bancoDados,
          onServiceAdded: _updateServiceList, 
        ),
      ),
    );
  }

  void _showDetails(Servico servico) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemDetailPage(
          servico: servico,
          bancoDados: widget.bancoDados, 
          onServiceUpdated: _updateServiceList, 
        ),
      ),
    );

    if (resultado == true) {
      _updateServiceList(); 
    }
  }

  void _updateServiceList() {
    setState(() {
    });
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
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemDetailPage extends StatelessWidget {
  final Servico servico;
  final BancoDados bancoDados;
  final Function onServiceUpdated;

  const ItemDetailPage({
    super.key,
    required this.servico,
    required this.bancoDados,
    required this.onServiceUpdated,
  });

  void _contratarServico(BuildContext context) {
    bancoDados.deletaServico(servico.id);
    onServiceUpdated(); 
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
