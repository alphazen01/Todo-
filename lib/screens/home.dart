import 'package:flutter/material.dart';
import 'package:todo/database_helper.dart';
import 'package:todo/screens/task_page.dart';
import 'package:todo/screens/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key,}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  void rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          // color: Color(0xffF6F6F6),
          color: Colors.grey,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 32),
                child: Image(image: AssetImage("assets/Group.png")),
              ),
              Expanded(
                child: FutureBuilder<List>(
                  initialData: [],
                    future: _dbHelper.getTask(),
                    builder: (context, snapshot) {
                      print(snapshot.data!.length);
                      return ListView.separated(
                        separatorBuilder: (context,index){
                          return  Row(
                              children: [
                                Text((index+1).toString(),style: TextStyle(fontSize: 16),),
                                SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: TaskCardWidget(
                                    title: snapshot.data![index].title,
                                    description: snapshot.data![index].description,
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                IconButton(
                                  onPressed: (){
                                    Navigator.push(
                                      context, MaterialPageRoute(builder: (_)=>TaskPage(rebuild: rebuild,customer: snapshot.data![index],))
                                      );
                                  }, 
                                  icon: Icon(Icons.edit)
                                ),
                                IconButton(
                                    onPressed: () async {
                                      await _dbHelper.deleteTask(
                                      snapshot.data![index].id);
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.delete,color: Colors.red,size: 50,),
                                )
                              ],
                            );
                           },
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return SizedBox(height: 20,);
                          });
                    }),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
              builder: (_) => TaskPage(
              rebuild: rebuild,
            )));
          },
          backgroundColor: Color(0xff7349FE),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
