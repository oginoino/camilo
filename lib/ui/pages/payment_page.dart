import 'package:flutter/services.dart';

import 'package:qr_flutter/qr_flutter.dart';

import '../../common_libs.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Checkout>(builder: (context, checkout, child) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                checkout.payment!.paymentMethod.methodDescription,
              ),
              floating: true,
              snap: true,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  appRouter.pop();
                },
              ),
            ),
            if (checkout.payment?.paymentMethod.methodType == 'pix')
              _buildPixPage(checkout, context),
          ],
        );
      }),
    );
  }

  SliverPadding _buildPixPage(Checkout checkout, BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            SizedBox(height: uiConstants.paddingLarge),
            Text(
              'Pagar total R\$${checkout.checkoutPrice}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: uiConstants.paddingLarge),
            // Pix QR Code
            Center(
              child: QrImageView(
                data: 'pix.example.com/qr/v2/9d36b84fc70b478fb95c12729b90ca25',
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
            SizedBox(
              height: uiConstants.paddingExtraLarge,
            ),
            Text(
              'Pix copia e cola',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: uiConstants.paddingMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: uiConstants.paddingMedium,
                      vertical: uiConstants.paddingSmall,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius:
                          BorderRadius.circular(uiConstants.borderRadiusMedium),
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.5),
                        style: BorderStyle.solid,
                        width: 1.5,
                      ),
                    ),
                    child: SelectableText(
                      'a1f4102e-a446-4a57-bcce-6fa48899c1d1',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      autofocus: true,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.copy,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5),
                  ),
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    Clipboard.setData(
                      const ClipboardData(
                        text: 'a1f4102e-a446-4a57-bcce-6fa48899c1d1',
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Copiado para a área de transferência'),
                      ),
                    );
                  },
                ),
              ],
            ),
            ValueListenableBuilder<String?>(
              valueListenable: checkout.payment!.statusNotifier,
              builder: (context, status, child) {
                if (status == 'pending') {
                  return TimerWidget(checkout: checkout);
                } else if (status == 'expired') {
                  return const ExpiredTimer();
                } else if (status == 'paid') {
                  return const PaidStatus();
                } else {
                  return Container(); // Placeholder
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TimerWidget extends StatelessWidget {
  final Checkout checkout;

  const TimerWidget({super.key, required this.checkout});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: uiConstants.paddingExtraExtraLarge),
        ValueListenableBuilder<int>(
          valueListenable: ValueNotifier<int>(checkout.remainingSeconds),
          builder: (context, remainingSeconds, child) {
            final minutes = remainingSeconds ~/ 60;
            final seconds = remainingSeconds % 60;
            final formattedTime =
                '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
            return Text(
              'Esse código expira em $formattedTime',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              textAlign: TextAlign.center,
            );
          },
        ),
        SizedBox(height: uiConstants.paddingExtraExtraLarge),
        Text(
          'Aguardando pagamento',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: uiConstants.paddingLarge),
        const Center(
          child: LinearProgressIndicator(),
        ),
      ],
    );
  }
}

class ExpiredTimer extends StatelessWidget {
  const ExpiredTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: uiConstants.paddingExtraExtraLarge),
          Text(
            'Código PIX expirado',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: uiConstants.yellowSubmarine,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: uiConstants.paddingLarge),
          Icon(
            Icons.error,
            color: uiConstants.yellowSubmarine,
            size: 48.0,
          ),
          SizedBox(height: uiConstants.paddingLarge),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: uiConstants.primaryLight,
            ),
            onPressed: () {
              checkout.resetTimer();
              checkout.setPaymentStatus('pending');
            },
            label: Text(
              'Gerar novo código PIX',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
            icon: Icon(
              Icons.refresh,
              color: uiConstants.backgroundLight,
            ),
          ),
        ],
      ),
    );
  }
}

class PaidStatus extends StatelessWidget {
  const PaidStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: uiConstants.paddingExtraExtraLarge),
          Text(
            'Pagamento confirmado!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: uiConstants.paddingLarge),
          Icon(
            Icons.check_circle_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 48.0,
          )
              .animate()
              .scaleXY(
                begin: 0.5,
                end: 1.5,
                curve: Curves.easeInOutCubic,
                duration: const Duration(milliseconds: 500),
              )
              .then()
            ..scaleXY(
              begin: 1.5,
              end: 1.0,
              curve: Curves.easeInOutCubic,
              duration: const Duration(milliseconds: 500),
            ),
          SizedBox(height: uiConstants.paddingLarge),
        ],
      ),
    );
  }
}
