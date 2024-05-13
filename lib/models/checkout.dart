import '../common_libs.dart';

class Checkout with ChangeNotifier {
  ProductCart? productCart;
  Address? address;
  double? deliveryTime;
  double? deliveryFee;
  String? promotionCode;
  double? promotionDiscount;
  double? discountPrice;
  double? checkoutPrice;
  Payment? payment;

  Checkout({
    this.address,
    this.deliveryTime,
    this.deliveryFee,
    this.promotionCode,
    this.promotionDiscount,
    this.discountPrice,
    this.checkoutPrice,
    this.payment,
    this.productCart,
  });

  @override
  String toString() {
    return 'Checkout{productCart: $productCart, address: $address, deliveryTime: $deliveryTime, deliveryFee: $deliveryFee, promotionCode: $promotionCode, promotionDiscount: $promotionDiscount, discountPrice: $discountPrice, checkoutPrice: $checkoutPrice, payment: $payment}';
  }

  void setPromotionCode(String promotionCode) {
    promotionCode = promotionCode;
    notifyListeners();
  }

  void setPromotionDiscount(double promotionDiscount) {
    promotionDiscount = promotionDiscount;
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
