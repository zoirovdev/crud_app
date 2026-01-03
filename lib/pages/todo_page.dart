import 'dart:convert';

import 'package:crud_app/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<StatefulWidget> createState() => _StateTodoPage();
}

class _StateTodoPage extends State<TodoPage> {
  List<Todo> todos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/todos");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        setState(() {
          todos = data.map((json) => Todo.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load");
      }
    } catch (e) {
      print("${e}");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
        backgroundColor: Colors.amberAccent[300],
        foregroundColor: Colors.black,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: CheckboxListTile(
                    value: todo.completed,
                    onChanged: (bool? value) => {},
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        decoration: todo.completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: todo.completed ? Colors.grey : Colors.black,
                      ),
                    ),
                    secondary: CircleAvatar(
                      backgroundColor: todo.completed
                          ? Colors.green
                          : Colors.red,
                      child: Icon(
                        todo.completed ? Icons.check : Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
