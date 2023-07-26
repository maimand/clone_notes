import 'package:clone_notes/app/data/models/note_model.dart';
import 'package:clone_notes/app/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NoteItem extends StatelessWidget {
  final NoteModel note;
  final Function() onDelete;
  final Function() onEdit;
  const NoteItem({
    required this.note,
    required this.onDelete,
    required this.onEdit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (context) {
                onDelete();
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete_outline,
              label: 'Delete',
            ),
          ],
        ),
        child: ListTile(
          onTap: () => onEdit,
          title: Text(note.title.isEmpty ? 'No title' : note.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text((note.timeStamp ?? DateTime.now()).toFEFormat()),
              Text(note.description),
            ],
          ),
        ));
  }
}
