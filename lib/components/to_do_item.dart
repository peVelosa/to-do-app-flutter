import 'package:flutter/material.dart';
import 'package:myapp/models/to_do.dart';

class ToDoItem extends StatelessWidget {
  const ToDoItem(
      {super.key,
      required this.toDo,
      required this.toggleIsDone,
      required this.deleteTodo});

  final ToDo toDo;
  final void Function(ToDo) toggleIsDone;
  final void Function(String id) deleteTodo;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
      ),
      onPressed: () {
        toggleIsDone(toDo);
      },
      child: Row(
        children: [
          Checkbox(
            value: toDo.isDone,
            onChanged: (_) {
              toggleIsDone(toDo);
            },
          ),
          Expanded(
            flex: 2,
            child: Text(
              toDo.title,
              style: TextStyle(
                decoration: toDo.isDone ? TextDecoration.lineThrough : null,
                color: Colors.black87,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Delete',
            onPressed: () {
              deleteTodo(toDo.id);
            },
            color: Colors.white,
            style: const ButtonStyle(
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
              backgroundColor: MaterialStatePropertyAll(
                Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}
