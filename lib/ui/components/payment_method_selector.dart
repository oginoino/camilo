import '../../common_libs.dart';

enum PaymentType {
  pix,
  creditCard,
}

extension PaymentMethodExtension on PaymentType {
  String get name {
    switch (this) {
      case PaymentType.pix:
        return 'Pague com PIX';
      case PaymentType.creditCard:
        return 'Escolha o cartão de crédito';
    }
  }

  String get description {
    switch (this) {
      case PaymentType.pix:
        return 'Pague com PIX';
      case PaymentType.creditCard:
        return 'Escolha o cartão de crédito';
    }
  }

  String get type {
    switch (this) {
      case PaymentType.pix:
        return 'pix';
      case PaymentType.creditCard:
        return 'credit-card';
    }
  }

  IconData get icon {
    switch (this) {
      case PaymentType.pix:
        return Icons.pix_rounded;
      case PaymentType.creditCard:
        return Icons.credit_card_rounded;
    }
  }
}

class PaymentMethodSelector extends StatefulWidget {
  final List<PaymentType> paymentMethods;
  final int selectedMethod;

  const PaymentMethodSelector({
    super.key,
    required this.paymentMethods,
    this.selectedMethod = 0,
  });

  @override
  State<PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  late int _selectedMethod;

  @override
  void initState() {
    super.initState();
    _selectedMethod = widget.selectedMethod;
    context.read<Checkout>().payment?.paymentMethod.selectMethod(
          widget.paymentMethods[_selectedMethod],
        );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.paymentMethods.length,
      itemBuilder: (context, index) {
        final method = widget.paymentMethods[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(
            method.icon,
            size: uiConstants.iconRadiusLarge,
          ),
          title: Text(
            method.name,
            style: Theme.of(context).listTileTheme.titleTextStyle?.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
          trailing: Radio<int>(
            value: index,
            groupValue: _selectedMethod,
            onChanged: (value) {
              setState(() {
                _selectedMethod = value!;
                context.read<Checkout>().payment?.paymentMethod.selectMethod(
                      widget.paymentMethods[_selectedMethod],
                    );
              });
            },
          ),
        );
      },
    );
  }
}
