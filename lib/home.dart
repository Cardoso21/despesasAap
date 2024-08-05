import 'dart:math';

import 'package:flutter/material.dart';
import 'components/chart.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';
import 'package:despesas_app/components/transaction_form.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  late bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.purple.shade400],
            // Ajuste as cores do gradiente de fundo
            begin: Alignment.bottomRight,
            end: Alignment.topRight,
          ),
        ),
      ),
      title: Center(
        child: Text(
          'Despesas Pessoais',
          style: TextStyle(fontSize: 20),
        ),
      ),
      actions: [
        if (isLandscape)
          IconButton(
            icon: Icon(_showChart ? Icons.list_alt : Icons.show_chart),
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
          ),
      ],
      elevation: 0, // Remove a sombra padrão do AppBar
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: Stack(
        children: [
          Container(
            height: availableHeight * 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.purple.shade400],
                // Ajuste as cores do gradiente de fundo
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(padding: EdgeInsets.all(10)),
                  if (_showChart || !isLandscape)
                    Container(
                      height: availableHeight * (isLandscape ? 0.65 : 0.3),
                      child: Chart(_recentTransactions),
                    ),
                  if (!_showChart || !isLandscape)
                    Container(
                      height: availableHeight * (isLandscape ? 0.9 : 0.7),
                      child: TransactionList(_transactions, _deleteTransaction),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width / 2 -
                28, // Centralizar o botão
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  // Gradiente para o botão
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(77, 76, 76, 0.5),
                    spreadRadius: 4,
                    blurRadius: 8,
                    offset: Offset(1, 3), // Offset da sombra
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () => _openTransactionFormModal(context),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.transparent,
                  // Torna o fundo do ElevatedButton transparente
                  padding: EdgeInsets.all(20),
                  // ajuste o padding conforme necessário
                  elevation: 0, // Remove a elevação padrão do ElevatedButton
                ),
                child: Icon(Icons.add, size: 30, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
