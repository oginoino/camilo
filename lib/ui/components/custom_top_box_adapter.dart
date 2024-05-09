import '../../common_libs.dart';

class CustomTopBoxAdapter extends StatelessWidget {
  const CustomTopBoxAdapter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30.0,
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
                  ),
                  SizedBox(width: uiConstants.paddingExtraSmall),
                  Text(
                    'Entrega em até 30 minutos!',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
                  .animate()
                  .scaleXY(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    begin: 0.9,
                    end: 1.0,
                  )
                  .then()
            ],
          ),
        ));
  }
}
