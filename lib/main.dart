import 'package:cute_todo_app/models/todo.dart';
import 'package:cute_todo_app/my-home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await Hive.initFlutter();
 Hive.registerAdapter(ToDoAdapter());
 await Hive.openBox<ToDo>('todosBox'); 

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHome(),
   ),
  );
}

