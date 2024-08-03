import 'package:despesas_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) delete; // Correção aqui

  TransactionList(this.transactions, this.delete);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(112, 191, 235, 150),
                      spreadRadius: 1,
                      blurRadius: 5,
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
                height: 350,
                child: Image.asset('assets/images/zzz.png', fit: BoxFit.cover),
              ),
            ],
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text(
                          'R\$${tr.value}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text(
                    DateFormat('d MMM y').format(tr.date),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () => delete(tr.id),
                  ),
                ),
              );
            },
          );
  }
}
