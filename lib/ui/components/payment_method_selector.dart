import '../../common_libs.dart';

class PaymentMethodSelector extends StatefulWidget {
  final List<PaymentMethod> paymentMethods;
  final ValueChanged<int> onSelected;
  final int selectedMethod;

  const PaymentMethodSelector({
    super.key,
    required this.paymentMethods,
    required this.onSelected,
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
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Selected method: $_selectedMethod');
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
              });
              widget.onSelected(_selectedMethod);
            },
          ),
        );
      },
    );
  }
}
