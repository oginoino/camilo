import 'package:flutter_animate/flutter_animate.dart';

import '../../common_libs.dart';

class CustomTopBoxAdapter extends StatelessWidget {
  const CustomTopBoxAdapter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 36.0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.schedule_rounded,
                    size: uiConstants.iconSizeSmall,
                    color: Theme.of(context).colorScheme.secondary,
                  ).animate().scaleXY(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      ),
                  SizedBox(width: uiConstants.paddingExtraSmall),
                  Text(
                    'Entrega em até 30 minutos',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
