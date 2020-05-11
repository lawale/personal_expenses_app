import 'package:flutter/material.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class UserTransactions extends StatelessWidget {
  
  final List<Transaction> transactions;

  UserTransactions(this.transactions);


  @override
  Widget build(BuildContext context) {
    return TranasctionList(transactions);
  }
}
