import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final String? title;
  final String? description;
  const TaskCardWidget({Key? key, this.title, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$title",
            style: TextStyle(
                color: Color(0xff211551),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "$description",
            style: TextStyle(
                color: Color(0xff868290),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1.5),
          ),
        ],
      ),
    );
  }
}

class TodoWidget extends StatefulWidget {
  const TodoWidget({Key? key}) : super(key: key);

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  bool isTap = false;
  Map<String, bool> task = {
    "Create your first Task": true,
    "Create your 2nd Task": true,
    "Create your 3rd Task": true,
    "Create your 4th Task": true,
  };
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            children: task.keys
                .map((ItemName) => CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Color(0xff7349FE),
                    shape: RoundedRectangleBorder(),
                    title: Text(
                      ItemName,
                      style: TextStyle(
                          color: task[ItemName]!
                              ? Colors.black
                              : Color(0xff868290),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    value: task[ItemName],
                    onChanged: (bool? value) {
                      setState(() {
                        task[ItemName] = value!;
                      });
                    }))
                .toList()));
  }
}

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
