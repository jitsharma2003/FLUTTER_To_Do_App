import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: TodoApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class TodoApp extends StatefulWidget {
  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List tasks = [];
  TextEditingController taskController = TextEditingController();

  void addTask() {
    String text = taskController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        tasks.add({"task": text, "done": false});
      });
      taskController.clear();
    }
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void toggleDone(int index) {
    setState(() {
      tasks[index]["done"] = !tasks[index]["done"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("My To-Do App"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      hintText: "Enter task...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade200,
                  ),
                  onPressed: addTask,
                  child: Text("Add"),
                ),
              ],
            ),
          ),
          Expanded(
            child: tasks.isEmpty
                ? Center(
              child: Text(
                "No tasks yet!",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: tasks[index]["done"],
                    onChanged: (value) {
                      toggleDone(index);
                    },
                  ),
                  title: Text(
                    tasks[index]["task"],
                    style: TextStyle(
                      decoration: tasks[index]["done"]
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      deleteTask(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
