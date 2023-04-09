import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'models/transaction.dart';
import './components/chart.dart';
import './components/transaction_form.dart';
import './components/transaction_list.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  final ThemeData tema = ThemeData();

  ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Travando a orientação para o modo retrato-cima
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp
    // ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
        theme: tema.copyWith(
          colorScheme: tema.colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.amber,
          ),
          textTheme: tema.textTheme.copyWith(
            titleLarge: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            titleMedium: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;
  final _transactions = [
    Transaction(
      id: 't0',
      title: 'Teste',
      value: 400.76,
      date: DateTime.now().subtract(const Duration(days: 33)),
    ),
    Transaction(
      id: 't1',
      title: 'Novo tênis de corrida',
      value: 310.76,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de luz #0',
      value: 211.30,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: 't3',
      title: 'Conta de luz #1',
      value: 211.30,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: 't4',
      title: 'Conta de luz #2',
      value: 211.30,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime datetime) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: datetime,
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
    Intl.defaultLocale = 'pt_BR';
    initializeDateFormatting('pt_BR', null);

    final mediaQuery = MediaQuery.of(context);

    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    Widget _getIconButton(IconData icon, Function() fn) {
      return Platform.isIOS
          ? GestureDetector(
              onTap: fn,
              child: Icon(icon),
            )
          : IconButton(
              onPressed: fn,
              icon: Icon(icon),
            );
    }

    final actions = [
      if (isLandscape)
        _getIconButton(
          _showChart ? Icons.list : Icons.show_chart,
          () => setState(() => _showChart = !_showChart),
        ),
      _getIconButton(
        Icons.add,
        () => _openTransactionFormModal(context),
      )
    ];

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Despesas pessoais'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          ) as PreferredSizeWidget
        : AppBar(
            title: const Text('Despesas Pessoais'),
            actions: actions,
          );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 0.8 : 0.3),
                child: Chart(_recentTransactions),
              ),
            if (!_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 1 : 0.7),
                child: TransactionList(_transactions, _deleteTransaction),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    mini: isLandscape,
                    onPressed: () => _openTransactionFormModal(context),
                    child: const Icon(Icons.add),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
