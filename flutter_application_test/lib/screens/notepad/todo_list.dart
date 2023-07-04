import 'package:flutter/material.dart';
import 'package:flutter_application_test/Models/todo_model.dart';
import 'package:flutter_application_test/Screens/notepad/todo_detail.dart';
import 'package:flutter_application_test/Utils/database_helper.dart';
import 'package:flutter_application_test/widgets/alert_dialog_yes_no_widget.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<TodoModel> todoList = [];

  @override
  void initState() {
    super.initState();
    _getDataFromDatabase();
  }

  Future<void> _getDataFromDatabase() async {
    List<TodoModel> todos = await databaseHelper.getAllData();
    setState(() {
      todoList = todos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     ElevatedButton(onPressed: () {}, child: const Text("All")),
          //     const SizedBox(width: 16.0),
          //     ElevatedButton(onPressed: () {}, child: const Text("Active")),
          //     const SizedBox(width: 16.0),
          //     ElevatedButton(onPressed: () {}, child: const Text("Completed")),
          //   ],
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                TodoModel todo = todoList[index];
                return Container(
                  alignment: Alignment.center,
                  margin: index == 0
                      ? const EdgeInsets.fromLTRB(10, 10.0, 10.0, 10.0)
                      : const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.black26)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      child: Text(
                        todo.title!.length > 2
                            ? todo.title!.substring(0, 2)
                            : todo.title!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Text(
                        todo.title!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Text(todo.description!)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${todo.date!.split(" ")[0]}\n${todo.date!.split(" ")[1]}",
                          textAlign: TextAlign.right,
                        ),
                        IconButton(
                          color: Colors.red,
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteTodo(context, todo.id!),
                        ),
                      ],
                    ),
                    onTap: () => _navigateToDetail(todo, "Edit Todo"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToDetail(TodoModel(), "Add Todo"),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _deleteTodo(BuildContext context, int id) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => const CustomAlertDialogYesNo(
        title: 'Confirmation',
        message: 'Are you sure you want to delete?',
      ),
    );
    if (result != null && result) {
      int result = await databaseHelper.deleteData(id.toString());
      if (result != 0) {
        // ignore: use_build_context_synchronously
        _showSnackBar(context, 'Todo Deleted Successfully');
        _getDataFromDatabase();
      }
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _navigateToDetail(TodoModel todo, String title) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodoDetail(title, todo)),
    );
    if (result == true) {
      _getDataFromDatabase();
    }
  }
}
