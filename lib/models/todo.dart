import 'package:hive/hive.dart';

part 'todo.g.dart'; 

@HiveType(typeId: 0) 
class ToDo extends HiveObject {
  @HiveField(0)
  String task;

  @HiveField(1)
  bool isDone;

  ToDo({required this.task, this.isDone = false});
}