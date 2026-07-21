import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/models/task_model.dart';

class TaskListWidget extends StatefulWidget {
  const TaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    this.emptyMessage,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final String? emptyMessage;

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.tasks.isEmpty
        ? Center(
            child: Text(
              "No Data",
              style: GoogleFonts.aclonica(
                fontSize: 24,
                color: Color(0xFFFFFCFC),
              ),
            ),
          )
        : ListView.separated(
            padding: EdgeInsets.only(bottom: 55),
            itemCount: widget.tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: 56,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFF282828),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Checkbox(
                        value: widget.tasks[index].isDone,
                        onChanged: (bool? value) {
                          widget.onTap(value, index);
                        },

                        activeColor: Color(0xFF15886C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tasks[index].taskName,
                              style: GoogleFonts.aclonica(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: widget.tasks[index].isDone
                                    ? Color(0xFFA0A0A0)
                                    : Color(0xFFFFFCFC),
                                decoration: widget.tasks[index].isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                decorationColor: Color(0xFFA0A0A0),
                                decorationThickness: 3,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            if (widget.tasks[index].taskDescription.isNotEmpty)
                              Text(
                                widget.tasks[index].taskDescription,
                                style: GoogleFonts.aclonica(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFC6C6C6),
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert,
                          color: widget.tasks[index].isDone
                              ? Color(0xFFA0A0A0)
                              : Color(0xFFC6C6C6),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 8);
            },
          );
  }
}
