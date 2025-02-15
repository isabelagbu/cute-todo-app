import 'package:cute_todo_app/add-task-modal-sheet.dart';
import 'package:cute_todo_app/models/todo.dart';
import 'package:cute_todo_app/todo-card.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyHome extends StatefulWidget {
  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  
  var todoBox = Hive.box<ToDo>('todosBox'); 

  void addTask(String task) {
    final newTodo = ToDo(task: task);
    todoBox.add(newTodo); 
  }

  void removeTask(int index) {
    todoBox.deleteAt(index); 
  }

  void editTask(int index) {
    final todo = todoBox.getAt(index);

    showModalBottomSheet(
      backgroundColor: const Color.fromARGB(100, 165, 182, 141),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AddTaskModalSheet(
          existingTask: todo?.task,
          onSave: (newTask) {
            if (todo != null) {
              setState(() {
                todo.task = newTask;
                todo.save(); 
              });
            }
          },
        );
      },
    );
  }

  Future<bool?> showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Color(0xFFF7F4ED),
          title: const Text('Confirm Delete'),
          content: const Text('Bestie are you sure?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel', style: TextStyle(color: Color(0xFFA5B68D))),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDE8DC),
      appBar: AppBar(
        title: const Text('My ToDo List'),
        backgroundColor: const Color(0xFFA5B68D),
        foregroundColor: Colors.white,
      ),
      body: ValueListenableBuilder(
        valueListenable: todoBox.listenable(),
        builder: (context, Box<ToDo> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('No tasks added yet.'));
          }
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final todo = box.getAt(index);
              return Dismissible(
                key: Key(todo!.task),
                direction: DismissDirection.horizontal,
                background: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Color(0xFFCAC6A3),
                  child: const Icon(Icons.edit, color: Colors.white, size: 30),
                ),
                secondaryBackground: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Color(0xFFDDAFAC),
                  child: const Icon(Icons.delete, color: Colors.white, size: 30),
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    editTask(index);
                    return false;
                  } else if (direction == DismissDirection.endToStart) {
                    return await showDeleteConfirmationDialog(context);
                  }
                  return false;
                },
                onDismissed: (direction) {
                  removeTask(index);
                },
                child: ToDoCard(todo: todo),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFEDE8DC),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            backgroundColor: const Color.fromARGB(100, 165, 182, 141),
            builder: (context) {
              return AddTaskModalSheet(
                onSave: (String task) {
                  addTask(task);
                },
              );
            },
          );
        },
        child: const Icon(Icons.add, size: 38, color: Color(0xFFA5B68D)),
      ),
    );
  }
}