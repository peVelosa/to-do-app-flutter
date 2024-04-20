import 'package:flutter/material.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({super.key, required this.addToDo});

  final void Function(String) addToDo;

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  bool isOpen = false;
  final newToDoController = TextEditingController();
  late FocusNode textFieldNode;

  @override
  void initState() {
    super.initState();
    textFieldNode = FocusNode();
  }

  @override
  void dispose() {
    newToDoController.dispose();
    textFieldNode.dispose();
    super.dispose();
  }

  void onChanged(String text) {
    setState(() {
      newToDoController.text = text;
    });
  }

  void handleOpen() {
    setState(() {
      isOpen = true;
    });
    textFieldNode.requestFocus();
  }

  void handleClose() {
    newToDoController.clear();
    textFieldNode.unfocus();
    setState(() {
      isOpen = false;
    });
  }

  void addTodo() {
    String newTodo = newToDoController.text;
    if (newTodo.isNotEmpty) {
      widget.addToDo(newTodo);
      newToDoController.clear();
      handleClose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          flex: 2,
          child: Visibility(
            visible: isOpen,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(2, 5),
                  ),
                ],
              ),
              child: TextField(
                focusNode: textFieldNode,
                controller: newToDoController,
                onChanged: onChanged,
                onTapOutside: (PointerDownEvent pointerDownEvent) {
                  if (newToDoController.text.isNotEmpty) return addTodo();
                  FocusScope.of(context).unfocus();
                },
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  hintText: 'Add a new to do item...',
                  suffixIconConstraints: const BoxConstraints(),
                  suffixIcon: newToDoController.text.isNotEmpty
                      ? IconButton(
                          onPressed: addTodo,
                          icon: const Icon(
                            Icons.check,
                          ),
                          padding: const EdgeInsets.all(0),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        IconButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 95, 65, 227),
            ),
            shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          color: Colors.white,
          onPressed: () {
            if (!isOpen) return handleOpen();
            handleClose();
          },
          icon: const Icon(
            Icons.add,
            size: 40,
          ),
        ),
      ],
    );
  }
}
