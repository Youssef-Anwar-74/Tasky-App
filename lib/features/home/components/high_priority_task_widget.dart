import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/core/widgets/custom_check_box.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/features/tasks/high_priority_screen.dart';

class HighPriorityTaskWidget extends StatelessWidget {
  const HighPriorityTaskWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.refresh,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function refresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "High Priority Tasks",
                  style: GoogleFonts.aclonica(
                    fontSize: 14,
                    color: Color(0xFF15886C),
                  ),
                ),
                SizedBox(height: 8),
                ...tasks.reversed.where((e) => e.isHighPriority).take(4).map((
                  element,
                ) {
                  return Row(
                    children: [
                      CustomCheckBox(
                        value: element.isDone,
                        onChanged: (bool? value) {
                          final index = tasks.indexWhere(
                            (e) => e.id == element.id,
                          );
                          onTap(value, index);
                        },
                      ),
                      Expanded(
                        child: Text(
                          element.taskName,

                          style: element.isDone
                              ? Theme.of(context).textTheme.titleLarge
                              : Theme.of(context).textTheme.titleMedium,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return HighPriorityScreen();
                  },
                ),
              );
              refresh();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 56,
                width: 48,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: ThemeController.isDark() ? Color(0xFF6E6E6E) : Color(0xFFD1DAD6)
                  ),
                ),
                child: SvgPicture.asset(
                    "assets/images/arrow_up_down.svg" ,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.secondary       ,
                      BlendMode.srcIn
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
