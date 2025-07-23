import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studio93/res/app_colors.dart';
import 'package:studio93/res/app_images.dart';
import 'package:svg_flutter/svg_flutter.dart';

class HelloCue extends StatefulWidget {
  final bool doPadding;
  const HelloCue({super.key, this.doPadding = true});

  @override
  State<HelloCue> createState() => _HelloCueState();
}

class _HelloCueState extends State<HelloCue>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: -3.0,
      end: 3.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      padding: widget.doPadding
          ? EdgeInsets.fromLTRB(23.w, 0, 20.w, 0)
          : EdgeInsets.zero,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _animation.value),
            child: Stack(
              fit: StackFit.loose,
              children: [
                Container(
                  color: AppColors.transparentColor,
                  child: SvgPicture.asset(
                    AppImages.helloImageSvg,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: 15,
                  left: 15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 5,
                    children: [
                      Text(
                        "Hello, I’m Cue",
                        style: Theme.of(
                          context,
                        ).textTheme.displayLarge!.copyWith(fontSize: 24),
                      ),
                      SizedBox(
                        width: 288,
                        height: 55,
                        child: Text(
                          'Your AI assistant. To start, tap below icon to Create Voice Reminder.',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
