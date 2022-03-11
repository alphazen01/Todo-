import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo/database_helper.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/screens/widget.dart';
import 'package:todo/task_model.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({
    Key? key,
    required this.rebuild,
  }) : super(key: key);
  final VoidCallback rebuild;
  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();

  int customerId = 0;
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
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
                Container(
                  color: Colors.red,
                  height: 400,
                  child: FutureBuilder(
                      future: DatabaseHelper.instance.getTask(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<CustomerModel>> snapshot) {
                        if (!snapshot.hasData) {
                          return Text("Loading......");
                        }
                        return ListView(
                            scrollDirection: Axis.vertical,
                            children: snapshot.data!.map((customer) {
                              return ListTile(
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {});
                                        },
                                        icon: Icon(Icons.edit)),
                                  ],
                                ),
                              );
                            }).toList());
                      }),
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
                TodoWidget()
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (_) => TaskPage()));
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
