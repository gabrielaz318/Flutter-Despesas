import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) deleteTransaction;

  const TransactionList(this.transactions, this.deleteTransaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 20,
                    ),
                    child: SizedBox(
                      height: constraints.maxHeight * 0.2,
                      child: Text(
                        'Nenhuma transação cadastrada!',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                          'R\$${tr.value}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  title: Text(tr.title,
                      style: Theme.of(context).textTheme.titleLarge),
                  subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? TextButton.icon(
                          onPressed: () => deleteTransaction(tr.id),
                          icon: const Icon(Icons.delete),
                          label: const Text('Excluir'),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.resolveWith(
                              (states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.white;
                                }

                                return Theme.of(context).colorScheme.error;
                              },
                            ),
                            overlayColor: MaterialStateProperty.resolveWith(
                              (states) {
                                return Theme.of(context).colorScheme.error;
                              },
                            ),
                          ),
                        )
                      : IconButton(
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).colorScheme.error,
                          onPressed: () => deleteTransaction(tr.id),
                        ),
                ),
              );
            },
          );
  }
}
