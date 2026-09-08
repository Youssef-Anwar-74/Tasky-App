import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/constants/app_sizes.dart';
import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/core/widgets/custom_check_box.dart';
import 'package:tasky_app/features/home/home_controller.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/features/tasks/high_priority_screen.dart';

import '../../tasks/tasks_controller.dart';

class HighPriorityTaskWidget extends StatelessWidget {
  const HighPriorityTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder:
          (BuildContext context, TasksController controller, Widget? child) {
            return Container(
              padding: EdgeInsets.all(AppSizes.w16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppSizes.r20),
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
                            fontSize: 14.sp,
                            color: Color(0xFF15886C),
                          ),
                        ),
                        SizedBox(height: AppSizes.h8),
                        ...controller.tasks.reversed
                            .where((e) => e.isHighPriority)
                            .take(4)
                            .map((element) {
                              return Row(
                                children: [
                                  CustomCheckBox(
                                    value: element.isDone,
                                    onChanged: (bool? value) {
                                      controller.doneTask(value, element.id);
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      element.taskName,
                                      style: element.isDone
                                          ? Theme.of(
                                              context,
                                            ).textTheme.titleLarge
                                          : Theme.of(
                                              context,
                                            ).textTheme.titleMedium,
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
                      controller.init();
                    },
                    child: Padding(
                      padding:  EdgeInsets.all(AppSizes.w16),
                      child: Container(
                        height: AppSizes.h56,
                        width: AppSizes.w48,
                        padding: EdgeInsets.all(AppSizes.pw16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ThemeController.isDark()
                                ? Color(0xFF6E6E6E)
                                : Color(0xFFD1DAD6),
                          ),
                        ),
                        child: SvgPicture.asset(
                          "assets/images/arrow_up_down.svg",
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.secondary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
    );
  }
}
