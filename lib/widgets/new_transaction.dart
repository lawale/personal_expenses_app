import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransactionHandler;

  NewTransaction(this._addNewTransactionHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  void submitData() {
    var parsedTitle = _titleController.text;
    var parsedAmount = double.parse(_amountController.text);
    print(parsedAmount);
    if (parsedTitle.isEmpty || parsedAmount <= 0) return;

    widget._addNewTransactionHandler(parsedTitle, parsedAmount);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              textInputAction: TextInputAction.next,
              controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              controller: _amountController,
              onSubmitted: (v) => submitData(),
            ),
            FlatButton(
              textColor: Theme.of(context).primaryColor,
              onPressed: submitData,
              child: Text("Add Transaction"),
            ),
          ],
        ),
      ),
    );
  }
}
