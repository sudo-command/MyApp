import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_test/Models/todo_model.dart';
import 'package:flutter_application_test/Utils/database_helper.dart';

class TodoDetail extends StatefulWidget {
  final String appBarTitle;
  final TodoModel todo;

  const TodoDetail(this.appBarTitle, this.todo);

  @override
  State<TodoDetail> createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.todo.title ?? '';
    descriptionController.text = widget.todo.description ?? '';
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle),
        actions: [
          IconButton(
            onPressed: _saveData,
            icon: const Icon(Icons.save_outlined),
            color: Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Flexible(
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  // border: InputBorder.none
                ),
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 16.0),
            Flexible(
              child: TextField(
                autofocus: true,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: descriptionController,
                decoration: const InputDecoration(
                    hintText: 'Note', border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  Future<void> _saveData() async {
    final TodoModel todo = widget.todo;
    todo.title = titleController.text;
    todo.description = descriptionController.text;

    final DateFormat formatter = DateFormat('d-MMM-yy H:mm');
    final String formatted = formatter.format(DateTime.now());
    todo.date = formatted;
    final int result = todo.id != null
        ? await databaseHelper.updateData(todo)
        : await databaseHelper.insertData(todo);

    if (result != 0) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context, true);
    } else {
      _showSnackBar('Failed to save Todo');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
