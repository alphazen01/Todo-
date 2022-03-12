import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo/database_helper.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/screens/widget.dart';
import 'package:todo/task_model.dart';

class TaskPage extends StatefulWidget {
  final CustomerModel?customer;
  const TaskPage({
    Key? key,
    required this.rebuild,
    this.customer
  }) : super(key: key);
  final VoidCallback rebuild;
  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
   DatabaseHelper _dbHelper = DatabaseHelper();
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();

  int customerId = 0;
  Random random = Random();
  @override
  void initState() {
  
    super.initState();
   if (widget.customer!=null) {
      titleEditingController.text=widget.customer!.title!;
    descriptionEditingController.text=widget.customer!.description!;
   }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                  // SizedBox(width: 10,),
                  Expanded(
                      child: TextField(
                    controller: titleEditingController,
                    decoration: InputDecoration(
                        hintText: "Enter Task Title",
                        border: InputBorder.none),
                    style: TextStyle(fontSize: 26, color: Color(0xff211551)),
                  )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: descriptionEditingController,
                  decoration: InputDecoration(
                      hintText: "Enter description for the task....",
                      border: InputBorder.none),
                  style: TextStyle(fontSize: 20, color: Color(0xff211551)),
                ),
              ),
              // Expanded(
              //   child: SizedBox()
              //   ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        print("data has been created");
                        //  Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
                      });
                      final customer = CustomerModel(
                        id: random.nextInt(100),
                        title: titleEditingController.text,
                        description: descriptionEditingController.text,
                      );
                      await DatabaseHelper.instance.insertTask(customer);
                      Navigator.pop(context);
                      widget.rebuild();
                    },
                    child: Text("Save"),
                 ),
                  ElevatedButton(
                    onPressed:() async{
                      final customer = CustomerModel(
                        id: widget.customer!.id,
                        title: titleEditingController.text,
                        description: descriptionEditingController.text,
                      );
                      await DatabaseHelper.instance.updateTask(customer);
                      titleEditingController.clear();
                       Navigator.pop(context);
                      widget.rebuild();
                     },
                     child: Text("Update"), 
                   ),
                 ],
               ),
             
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
          if (widget.customer!=null) {
            await _dbHelper.deleteTask(
          widget.customer!.id!);
          Navigator.pop(context);
          widget.rebuild();
          }
        },
          backgroundColor: Color(0xFFFE3577),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Icon(Icons.delete_forever),
        ),
      ),
    );
  }
}
