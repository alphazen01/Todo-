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
                child: Container(
                  height:400,
                  
                  decoration: BoxDecoration(
                   color: Colors.blue,
                   borderRadius: BorderRadius.circular(20)
                  ),
                  child: TextField(maxLines: 10,
                    controller: descriptionEditingController,
                    decoration: InputDecoration(
                    hintText: "Enter description for the task....",
                    border: InputBorder.none,
                      ),
                    style: TextStyle(fontSize: 20, color: Color(0xff211551)),
                  ),
                ),
              ),
              // Expanded(
              //   child: SizedBox()
              //   ),
              
             
            ],
          ),
        ),
        floatingActionButton: Column(
          
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
              SizedBox(
                width: 70,
                child: ElevatedButton(
                   style:ElevatedButton.styleFrom(
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ) 
                        
                      ) ,
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
              ),
                  ElevatedButton(
                    style:ElevatedButton.styleFrom(
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ) 
                      
                    ) ,
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
                     child: Text(
                       "Update",
                       style: TextStyle(fontSize: 12),
                     ), 
                   ),
                  SizedBox(width:20),
            FloatingActionButton(
              onPressed: () async {
                // _showDialog(context);
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
          ],
        ),
      ),
    );
  }
}
_showDialog(BuildContext context){
  showDialog(
    barrierDismissible: false,
  context: context, 
  builder:(BuildContext context){
    return AlertDialog(
    title: Text("alert"),
    content: Text("This the body of alert dialog"),
    actions: [
      TextButton(
        onPressed: (){
         
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
  );
}
