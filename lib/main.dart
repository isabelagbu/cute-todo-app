import 'package:cute_todo_app/add-task-modal-sheet.dart';
import 'package:cute_todo_app/model/ToDo.dart';
import 'package:cute_todo_app/todo-card.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHome(),
   ),
  );
}

class MyHome extends StatefulWidget {

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
 List<ToDo> todos = [
    ToDo(task: "Wash the Dishes"),
    ToDo(task: "Complete Flutter Project"),
    ToDo(task: "Read a Book"),
    ToDo(task: "Go for a Walk"),
    ToDo(task: "Go for a Walk"),
    ToDo(task: "Go for a Walk"),
    ToDo(task: "Go for a Walk"),
    ToDo(task: "Go for a Walk"),
    ToDo(task: "Go for a Walk"),
 ];

 void addTask(String taskName) {
  setState(() {
    todos.add(ToDo(task: taskName));
  });
 }

  // ✅ Function to remove a task
  void removeTask(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

    // ✅ Function to show a confirmation dialog before deleting
  Future<bool?> showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Color(0xFFF7F4ED),
          title: const Text("Confirm Delete"),
          content: const Text("Bestie are you sure?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false), // ✅ Cancel
              child: const Text("Cancel", style: TextStyle(color: const Color(0xFFA5B68D),),),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true), // ✅ Confirm delete
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

void editTask(int index) {
  showModalBottomSheet(
    backgroundColor: const Color.fromARGB(100, 165, 182, 141),
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return AddTaskModalSheet(
        existingTask: todos[index].task, // ✅ Prefill the text field
        onSave: (newTask) {
          setState(() {
            todos[index].task = newTask; // ✅ Save edited task
          });
        },
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDE8DC),
      appBar: AppBar(
        title: Text('Isabel\'s ToDo List'),
        backgroundColor: const Color(0xFFA5B68D),
        foregroundColor: Colors.white,
      ),
        body: Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(todos[index].task),
                  background: Container( // ✅ Swipe right for edit
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: Color(0xFFCAC6A3), // ✅ Blue for edit
                    child: const Icon(Icons.edit, color: Colors.white, size: 30),
                  ),
                  secondaryBackground: Container( // ✅ Swipe left for delete
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: Color(0xFFDDAFAC), // ✅ Red for delete
                    child: const Icon(Icons.delete, color: Colors.white, size: 30),
                  ),
                  direction: DismissDirection.horizontal, // ✅ Allows left & right swipes
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                        editTask(index); 
                        return false; 
                    } else if (direction == DismissDirection.endToStart) {
                          final confirm = await showDeleteConfirmationDialog(context);
                          return confirm ?? false; 
                    }
                        return false;
                  },
                  onDismissed: (direction) {
                    removeTask(index);
                  },
                  child: ToDoCard(todo: todos[index]),
                );
              },
             ),
            ),
            SizedBox(height: 10),
          ],
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
                setState(() {
                  todos.add(ToDo(task: task)); // ✅ Add new task
                });
              },
            );
            },
          );
        },
        child: const Icon(
          Icons.add,
          size: 38,
          color: Color(0xFFA5B68D),
        ),
      ),
    );
  }
}



