import 'package:despesas_app/components/transaction_item.dart';
import 'package:despesas_app/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) delete; // Correção aqui

  TransactionList(this.transactions, this.delete);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: -5,
                          blurRadius: 8,
                          offset: Offset(1, 1), // Muda a posição da sombra
                        ),
                      ],
                    ),
                    child: Text(
                      'Nenhuma Transação Cadastrada',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.7,
                    child:
                        Image.asset('assets/images/zzz.png', fit: BoxFit.cover),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return TransactionItem(tr: tr, delete: delete);
            },
          );
  }
}


