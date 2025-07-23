import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio93/view/home_screen/bloc/home_bloc.dart';
import 'package:studio93/view/home_screen/bloc/home_event.dart';

deleteDialog(BuildContext context, String id) {
  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text("Task Deleting"),
        content: Text(
          "Are You Sure to delete this task",
          style: Theme.of(context).textTheme.bodySmall,
          maxLines: 3,
          textAlign: TextAlign.center,
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(
              "Cancel",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(
              "Delete",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: Colors.blue),
            ),
            onPressed: () {
              context.read<HomeBloc>().add(DeleteTaskHomeEvent(id: id));
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
