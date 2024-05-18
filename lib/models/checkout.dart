import 'package:uuid/uuid.dart';

import '../common_libs.dart';

class Checkout with ChangeNotifier {
  ProductCart? _productCart;
  late UserData _payer;
  final double _deliveryTime = 15;
  final double _deliveryFee = 5;
  Payment? _payment;

  Checkout() {
    _payment = Payment();
    _payment?.setPaymentUniqueId();
  }

  ProductCart? get productCart => _productCart;
  Address? get deliveryAddress => _payer.selectedAddress;
  double get deliveryTime => _deliveryTime;
  double get deliveryFee => _deliveryFee;
  Payment? get payment => _payment;
  UserData get payer => _payer;

  String get checkoutPrice =>
      (_productCart!.totalPrice + _deliveryFee).toStringAsFixed(2);

  @override
  String toString() {
    return 'Checkout{productCart: $productCart, deliveryAddress: $deliveryAddress, deliveryTime: $deliveryTime, deliveryFee: $deliveryFee, checkoutPrice: $checkoutPrice, payment: $payment}';
  }

  void setPayer(UserData? user) {
    _payer = user!;
    _payment?.setPayer(user); // Atualiza o pagador no Payment
    notifyListeners();
  }

  void setProductCart(ProductCart productCart) {
    _productCart = productCart;
    _payment?.setItems(productCart); // Atualiza os itens no Payment
    _payment?.setTotal(
        productCart.totalPrice + _deliveryFee); // Atualiza o total no Payment
    notifyListeners();
  }

  void setPaymentMethod(PaymentMethod paymentMethod) {
    _payment?.setPaymentMethod(paymentMethod);
    notifyListeners();
  }
}

class Payment with ChangeNotifier {
  String? _paymentId;
  PaymentMethod? _paymentMethod;
  final ValueNotifier<String> _status = ValueNotifier<String>('pending');
  ProductCart? _items;
  UserData? _payer;
  double? _total;

  String get paymentId => _paymentId!;
  PaymentMethod get paymentMethod => _paymentMethod!;
  String get status => _status.value;
  ProductCart get items => _items!;
  UserData get payer => _payer!;
  double get total => _total!;

  ValueNotifier<String> get statusNotifier => _status;

  Payment get payment => this;

  Payment() {
    _paymentMethod = PaymentMethod();
  }

  @override
  String toString() {
    return 'Payment{paymentId: $paymentId, paymentMethod: $paymentMethod, status: $status, items: $items, payer: $payer, total: $total}';
  }

  void setStatus(String status) {
    _status.value = status;
    notifyListeners();
  }

  void setPaymentMethod(PaymentMethod paymentMethod) {
    _paymentMethod = paymentMethod;
    notifyListeners();
  }

  void setItems(ProductCart items) {
    _items = items;
    notifyListeners();
  }

  void setPayer(UserData payer) {
    _payer = payer;
    notifyListeners();
  }

  void setTotal(double total) {
    _total = total;
    notifyListeners();
  }

  void setPaymentUniqueId() {
    _paymentId = const Uuid().v4();
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

  void selectMethod(PaymentType paymentType) {
    _methodType = paymentType.type;
    _methodDescription = paymentType.description;
    notifyListeners();
  }
}
