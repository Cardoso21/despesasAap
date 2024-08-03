import 'dart:math';

import 'package:despesas_app/components/transaction_form.dart';
import 'package:flutter/material.dart';

import 'components/chart.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

class MyHomoPage extends StatefulWidget {
  @override
  State<MyHomoPage> createState() => _MyHomoPageState();
}

class _MyHomoPageState extends State<MyHomoPage> {
  final List<Transaction> _transactions = [];

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
    final appBar = AppBar(
      title: Center(
        child: Text(
          'Despesas Pessoais',
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        ),
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      backgroundColor: Color.fromRGBO(110, 141, 220, 1.0),
      // Defina a cor de fundo aqui
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: availableHeight * 0.3,
                  child: Chart(_recentTransactions),
                ),
                Container(
                  height: availableHeight * 0.7,
                  child: TransactionList(_transactions, _deleteTransaction),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width / 2 - 28, // Centralizar o botão
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color:  Color.fromRGBO(77, 76, 76, 0.5),
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
                  backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                  padding: EdgeInsets.all(20), // ajuste o padding conforme necessário
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
