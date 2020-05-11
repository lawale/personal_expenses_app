import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chartbar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  Chart(this.transactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var sum = 0.0;

      transactions.forEach((transaction) {
        if (transaction.date.day == weekDay.day &&
            transaction.date.year == weekDay.year &&
            transaction.date.month == weekDay.month) {
          sum += transaction.amount;
        }
      });

      print("WeekDay: ${DateFormat.E().format(weekDay)} \nAmount \$$sum");
      return {"day": DateFormat.E().format(weekDay), "amount": sum};
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item["amount"];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);

    return Card(
      color: Colors.white,
      elevation: 8,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((groupedTransaction) {
            var day = groupedTransaction["day"];
            var amount = groupedTransaction["amount"] as double;
            var portion = amount / maxSpending;
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                day,
                amount,
                portion.isNaN || portion.isNegative ? 0.0 : portion,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
