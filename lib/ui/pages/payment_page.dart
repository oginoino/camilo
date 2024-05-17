import 'package:flutter/services.dart';
import '../../common_libs.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

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
            // Pix PQ Code
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            SizedBox(height: uiConstants.paddingLarge),
            if (checkout.payment?.status == 'pending')
              TimerWidget(checkout: checkout),
            if (checkout.payment?.status == 'expired') const ExpiredTimer(),
          ],
        ),
      ),
    );
  }
}

class TimerWidget extends StatefulWidget {
  final Checkout checkout;

  const TimerWidget({super.key, required this.checkout});

  @override
  TimerWidgetState createState() => TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  int _remainingSeconds = 300; // 5 minutos em segundos

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
        _expirePayment();
      }
    });
  }

  void _expirePayment() {
    setState(() {
      widget.checkout.payment?.setStatus('expired');
      appRouter.pop();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: uiConstants.paddingExtraExtraLarge),
        Text(
          'Esse código expira em ${_formatDuration(_remainingSeconds)}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
          textAlign: TextAlign.center,
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

class ExpiredTimer extends StatefulWidget {
  const ExpiredTimer({
    super.key,
  });

  @override
  State<ExpiredTimer> createState() => _ExpiredTimerState();
}

class _ExpiredTimerState extends State<ExpiredTimer> {
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
            onPressed: () {
              setState(() {
                checkout.payment?.setStatus('pending');
                appRouter.pop();
              });
            },
            label: const Text('Gerar novo código PIX'),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
