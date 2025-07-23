import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studio93/res/app_images.dart';
import 'package:studio93/view/home_screen/widgets/hello_cue.dart';
import 'package:svg_flutter/svg_flutter.dart';

class EmptyTaskWidget extends StatelessWidget {
  const EmptyTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: constraints.maxHeight * 0.08),
              Center(
                child: SvgPicture.asset(
                  AppImages.emptyIconSvg,
                  width: constraints.maxHeight * 0.4,
                  placeholderBuilder: (BuildContext context) => Container(
                    width: constraints.maxHeight * 0.4,
                    height: constraints.maxHeight * 0.4,
                    padding: EdgeInsets.all(constraints.maxHeight * 0.1),
                    child: const CircularProgressIndicator(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Text(
                  'There are no tasks',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 1.h),
                child: Text(
                  'Just tap and tell the personal assistant your task or plans. It’s that simple',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const Spacer(),
              const HelloCue(),
              const Spacer(flex: 5),
              SizedBox(height: 10.h + MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        );
      },
    );
  }
}
