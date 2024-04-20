import 'package:flutter/material.dart';
import 'package:myapp/components/to_do_item.dart';
import 'package:myapp/models/to_do.dart';

class ToDoSection extends StatelessWidget {
  ToDoSection({
    super.key,
    required this.toDos,
    required this.filter,
    required this.toggleIsDone,
    required this.deleteTodo,
  });

  final List<ToDo> toDos;
  final String filter;
  final void Function(ToDo) toggleIsDone;
  final void Function(String id) deleteTodo;
  final ScrollController? scrollController = ScrollController();

  List<Widget> getTodos() {
    return toDos
        .map(
          (toDo) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ToDoItem(
              toDo: toDo,
              deleteTodo: deleteTodo,
              toggleIsDone: toggleIsDone,
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        decoration: const BoxDecoration(color: Colors.transparent),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'All To Do\'s',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: Scrollbar(
                controller: scrollController,
                thumbVisibility: true,
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.only(right: 10),
                  children: getTodos(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
