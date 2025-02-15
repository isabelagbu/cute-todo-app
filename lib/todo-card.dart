import 'package:cute_todo_app/model/ToDo.dart';
import 'package:flutter/material.dart';

class ToDoCard extends StatefulWidget {
  final ToDo todo;

  const ToDoCard({super.key, required this.todo});

  @override
  State<ToDoCard> createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Card(
            elevation: 0,
              color: widget.todo.isDone ? Color(0xFFE7CCCC) : Color(0xFFA5B68D),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 26,horizontal: 30),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.todo.isDone = !widget.todo.isDone;
                        });
                      },
                      child: Container(
                        height: 26,
                        width: 26,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDE8DC),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: widget.todo.isDone ? Image.asset('assets/imgs/heart.png') : null,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      widget.todo.task,
                      style: TextStyle(
                        decorationThickness: 2.0,
                        decorationColor: Color(0xFFE7CCCC),
                        decoration: widget.todo.isDone ? TextDecoration.lineThrough : null,
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
          ),
        ),
          SizedBox(height: 5),
      ],
    );
  }
}