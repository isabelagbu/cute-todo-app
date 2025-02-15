import 'package:flutter/material.dart';

class AddTaskModalSheet extends StatefulWidget {
  final Function(String) onSave; 
  final String? existingTask;

  const AddTaskModalSheet({
    super.key,
    required this.onSave,
    this.existingTask,
  });

  @override
  State<AddTaskModalSheet> createState() => _AddTaskModalSheetState();
}

class _AddTaskModalSheetState extends State<AddTaskModalSheet> {

  late TextEditingController _todoController; 

  @override
  void initState() {
    super.initState();
    _todoController = TextEditingController(text: widget.existingTask ?? ""); 
  }

  @override
  void dispose() {
    _todoController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 70.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _todoController,
              maxLines: 6,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFEDE8DC), 
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 192, 238, 127),
                    width: 2,
                  ),
                ),
                hintText: widget.existingTask == null ? "Enter your task..." : "Edit your task...", 
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_todoController.text.isNotEmpty) {
                  widget.onSave(_todoController.text); 
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(
                    color: Color(0xFFEDE8DC),
                    width: 1,
                  ),
                ),
                backgroundColor: const Color(0xFFA5B68D),
                minimumSize: const Size(150, 50),
              ),
              child: Text(
                widget.existingTask == null ? 'Add ToDo' : 'Edit ToDo', 
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}