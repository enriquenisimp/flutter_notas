import 'package:flutter/material.dart';
import 'package:flutter_notas/keys.dart';

import 'package:flutter_notas/models/todo.dart';

typedef OnSaveCallback = Function(String task, String note, DateTime when, String category);


class AddTodoScreen extends StatefulWidget {
  final OnSaveCallback onSave;
  final bool isEditing;
  final Todo todo;
  const AddTodoScreen({Key key,@required this.onSave, this.todo, @required this.isEditing}) : super(key: key);

  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool get isEditing => widget.isEditing;

  String _task;
  String _note;
  DateTime _when;
  String _category;
  DateTime picked;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    picked=DateTime.now();
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final String args = ModalRoute.of(context).settings.arguments;

    _category=args;
    final TextEditingController myController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? "Edit Task" : "Add new Task",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,

          child: ListView(
            children: [
              TextFormField(
                initialValue: isEditing ? widget.todo.task : '',
                key: ArchSampleKeys.taskField,
                autofocus: !isEditing,
                style: textTheme.headline5,
                decoration: InputDecoration(
                  hintText:"Title"
                ),
                validator: (val){
                  return val.trim().isEmpty ? "This text box can't be empty" : null;
                },
                onChanged: (value)=>_task=value,
                onSaved :(value) =>_task = value,
              ),
              TextFormField(
                initialValue: isEditing ? widget.todo.note : '',
                autofocus: true,
                decoration: InputDecoration(
                    hintText:"Description"
                ),
                onChanged: (value)=>_note=value,
                onSaved: (value)=>_note=value,
              ),
              GestureDetector(
                onTap: () async {
                  DateTime pickedaux= await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(),
                      lastDate: DateTime(2100));
                  setState(() {
                    picked=pickedaux;
                    myController.value=TextEditingValue(text: picked.toString());
                    myController.text= picked.toString();
                  });
                } ,
                child: AbsorbPointer(
                  child: TextFormField(

                    controller: myController,
                    autofocus: true,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        hintText:"Choose a day"
                    ),
                    onSaved: (value){
                      myController.text= picked.toString();
                      _when=picked;
                    }

                  ),
                ),
              ),

            ],
          ),

        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isEditing ? Icons.edit : Icons.add),
        key: isEditing ? ArchSampleKeys.saveTodoFab : ArchSampleKeys.saveNewTodo,
        onPressed: () {
          if(_formKey.currentState.validate())
            {
              _formKey.currentState.save();
              widget.onSave(_task, _note, _when, _category ?? widget.todo.category);
              Navigator.pop(context);
            }
        },

      ),
    );
  }
}
