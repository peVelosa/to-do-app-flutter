import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/components/elements/add_to_do.dart';
import 'package:myapp/components/search.dart';
import 'package:myapp/components/to_do_section.dart';
import 'package:myapp/models/to_do.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _startApp();
  }

  @override
  void dispose() {
    filterController.dispose();
    super.dispose();
  }

  final List<ToDo> _toDos = [];
  final filterController = TextEditingController();

  _startApp() async {
    await _startPrefs();
    await _loadData();
  }

  _startPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _loadData() async {
    final List<dynamic> jsonData =
        jsonDecode(_prefs.getString('toDos') ?? '[]');
    setState(() {
      _toDos.clear();
      for (var toDo in jsonData) {
        final toDoItem = ToDo.fromMap(toDo);
        _toDos.add(toDoItem);
      }
    });
  }

  void persistData() {
    final toDos = _toDos.map((toDo) => toDo.toJson()).toList();
    _prefs.setString('toDos', jsonEncode(toDos));
  }

  void filter(String text) {
    setState(() {
      filterController.text = text;
    });
  }

  void changeIsDone(ToDo toDo) {
    setState(
      () {
        toDo.isDone = !toDo.isDone;
      },
    );
    persistData();
  }

  void addToDo(String title) {
    setState(() {
      _toDos.add(ToDo(title: title, isDone: false, id: '${DateTime.now()}'));
    });
    persistData();
  }

  void deleteTodo(String id) {
    setState(() {
      _toDos.removeWhere((todo) => todo.id == id);
    });
    persistData();
  }

  List<ToDo> _buildToDos() {
    return _toDos
        .where((toDo) => toDo.title
            .toLowerCase()
            .contains(filterController.text.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Search(controller: filterController, onChanged: filter),
          ToDoSection(
            filter: filterController.text,
            toDos: _buildToDos(),
            toggleIsDone: changeIsDone,
            deleteTodo: deleteTodo,
          ),
          AddToDo(addToDo: addToDo),
        ],
      ),
    );
  }
}
