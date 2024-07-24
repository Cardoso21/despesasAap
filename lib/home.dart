import 'package:flutter/material.dart';

import 'components/transaction_user.dart';

class MyHomoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Card(
              color: Colors.blue,
              child: Text('Grafico'),
            ),
          ),
          TransactionUser(),
        ],
      ),
    );
  }
}