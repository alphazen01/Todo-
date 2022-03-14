import 'package:flutter/material.dart';
import 'package:todo/database_helper.dart';
import 'package:todo/task_model.dart';

class CustomAlert extends StatefulWidget {
    final CustomerModel?customer;
    final VoidCallback rebuild;
  const CustomAlert({
    Key? key,this.customer,
    required this.rebuild,
  }) : super(key: key);

  @override
  State<CustomAlert> createState() => _CustomAlertState();
}

class _CustomAlertState extends State<CustomAlert> {
   DatabaseHelper _dbHelper = DatabaseHelper();

  void rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
    title: Text("alert"),
    content: Text("This the body of alert dialog"),
    actions: [
        TextButton(
         onPressed: () async {
              if (widget.customer!=null) {
                await _dbHelper.deleteTask(
              widget.customer!.id!);
              Navigator.pop(context);
              widget.rebuild();
              }
            },
        child: Text("Yes")
        ),
         TextButton(
        onPressed: (){
          Navigator.pop(context);
        }, 
        child: Text("No")
        ),
    ],
    );
  }
}

