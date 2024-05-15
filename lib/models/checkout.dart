import '../common_libs.dart';

class Checkout with ChangeNotifier {
  late ProductCart _productCart;
  late Address _address;
  late UserData _payer;
  final double _deliveryTime = 15;
  final double _deliveryFee = 5;
  late double _checkoutPrice;
  Payment? _payment;

  ProductCart get productCart => _productCart;
  Address? get address => _address;
  double get deliveryTime => _deliveryTime;
  double get deliveryFee => _deliveryFee;
  double get checkoutPrice => _checkoutPrice;
  Payment? get payment => _payment;
  UserData get payer => _payer;

  @override
  String toString() {
    return 'Checkout{productCart: $productCart, address: $address, deliveryTime: $deliveryTime, deliveryFee: $deliveryFee, checkoutPrice: $checkoutPrice, payment: $payment}';
  }

  void setAddress(Address address) {
    _address = address;
    notifyListeners();
  }
}

class Payment with ChangeNotifier {
  String? _paymentId;
  PaymentMethod? _paymentMethod;
  String? _status;
  ProductCart? _items;
  UserData? _payer;
  double? _total;

  String get paymentId => _paymentId!;
  PaymentMethod get paymentMethod => _paymentMethod!;
  String get status => _status!;
  ProductCart get items => _items!;
  UserData get payer => _payer!;
  double get total => _total!;

  Payment get payment => this;

  @override
  String toString() {
    return 'Payment{paymentId: $paymentId, paymentMethod: $paymentMethod, status: $status, items: $items, payer: $payer, total: $total}';
  }

  void setStatus(String status) {
    _status = status;
    notifyListeners();
  }

  void setPaymentMethod(PaymentMethod paymentMethod) {
    _paymentMethod = paymentMethod;
    notifyListeners();
  }
}

class PaymentMethod with ChangeNotifier {
  String? _methodType;
  String? _methodDescription;
  Map<String, dynamic>? _methodData;

  String get methodType => _methodType!;
  String get methodDescription => _methodDescription!;
  Map<String, dynamic> get methodData => _methodData!;

  PaymentMethod get paymentMethod => this;

  @override
  String toString() {
    return 'PaymentMethod{ methodType: $methodType, methodDescription: $methodDescription}';
  }

  void setMethodType(String methodType) {
    _methodType = methodType;
    notifyListeners();
  }

  void setMethodDescription(String methodDescription) {
    _methodDescription = methodDescription;
    notifyListeners();
  }

  void setMethodData(Map<String, dynamic> methodData) {
    _methodData?.addAll(methodData);
    notifyListeners();
  }
}
