import "package:flutter/material.dart";
import "package:flutter_custom_clippers/flutter_custom_clippers.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:studio93/res/app_colors.dart";

const color = [
  Color(0xff7BD5F5),
  Color(0xff787FF6),
  Color(0xff4ADEDE),
  Color(0xff1CA7EC),
  Color(0xff1F2F98),
];
final List<int> duration = [900, 700, 600, 800, 500];

class ListeningAnimation extends StatelessWidget {
  final bool isListening;
  final String result;
  final String status;

  const ListeningAnimation({
    super.key,
    required this.result,
    required this.isListening,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      bottom: isListening ? 0 : -MediaQuery.of(context).size.height,
      left: 0,
      right: 0,
      height: MediaQuery.of(context).size.height,
      child: ClipPath(
        clipper: OvalTopBorderClipper(),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AnimationMessageListening(
              childWidget: ClipPath(
                clipper: OvalTopBorderClipper(),
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.6,
                  color: AppColors.primaryColor.withAlpha(50),
                ),
              ),
            ),
            AnimationMessageListening(
              childWidget: ClipPath(
                clipper: OvalTopBorderClipper(),
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.7,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withAlpha(100),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.sizeOf(context).height * 0.41,
              child: AnimationMessageListening(
                childWidget: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.49,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.6,
                          height: MediaQuery.sizeOf(context).height * 0.12,
                          child: ListeningAnimationWidget(
                            barCount: 20,
                            duration: duration,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.22,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          child: Text(
                            result,
                            textAlign: TextAlign.center,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(fontSize: 14),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          status,
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall!.copyWith(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListeningAnimationWidget extends StatelessWidget {
  final List<int>? duration;
  final int? barCount;
  final Curve? curve;

  const ListeningAnimationWidget({
    super.key,
    required this.duration,
    required this.barCount,
    this.curve = Curves.easeInQuad,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List<Widget>.generate(
        barCount!,
        (index) => _VisualComponentListeningAnimation(
          curve: curve!,
          duration: duration![index % 5],
          color: color[index % 4],
        ),
      ),
    );
  }
}

class _VisualComponentListeningAnimation extends StatefulWidget {
  final int? duration;
  final Color? color;
  final Curve? curve;

  const _VisualComponentListeningAnimation({
    required this.duration,
    required this.color,
    required this.curve,
  });

  @override
  State<_VisualComponentListeningAnimation> createState() =>
      _VisualComponentListeningAnimationState();
}

class _VisualComponentListeningAnimationState
    extends State<_VisualComponentListeningAnimation>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animate();
  }

  @override
  void dispose() {
    animation!.removeListener(() {});
    animation!.removeStatusListener((status) {});
    animationController!.stop();
    animationController!.reset();
    animationController!.dispose();
    super.dispose();
  }

  void animate() {
    animationController = AnimationController(
      duration: Duration(milliseconds: widget.duration!),
      vsync: this,
    );
    final curvedAnimation = CurvedAnimation(
      parent: animationController!,
      curve: widget.curve!,
    );
    animation = Tween<double>(begin: 15, end: 70).animate(curvedAnimation)
      ..addListener(() {
        update();
      });
    animationController!.repeat(reverse: true);
  }

  void update() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: animation!.value,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xffB48BEB), Color(0xffF77F5A)],
          begin: Alignment.topRight,
          end: Alignment.bottomCenter,
        ),
        color: widget.color,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class AnimationMessageListening extends StatelessWidget {
  final Widget childWidget;
  const AnimationMessageListening({super.key, required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 300),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)), // Slide up effect
            child: childWidget,
          ),
        );
      },
    );
  }
}
