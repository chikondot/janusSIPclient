///
//  Generated code. Do not modify.
//  source: lib/src/communication/protos/payments.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class PaymentStatus extends $pb.ProtobufEnum {
  static const PaymentStatus SUCCESS = PaymentStatus._(0, 'SUCCESS');
  static const PaymentStatus FAILED = PaymentStatus._(1, 'FAILED');
  static const PaymentStatus PENDING = PaymentStatus._(2, 'PENDING');

  static const $core.List<PaymentStatus> values = <PaymentStatus> [
    SUCCESS,
    FAILED,
    PENDING,
  ];

  static final $core.Map<$core.int, PaymentStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PaymentStatus valueOf($core.int value) => _byValue[value];

  const PaymentStatus._($core.int v, $core.String n) : super(v, n);
}

class PaymentMethod extends $pb.ProtobufEnum {
  static const PaymentMethod PAYPAL = PaymentMethod._(0, 'PAYPAL');
  static const PaymentMethod PAYNOW = PaymentMethod._(1, 'PAYNOW');
  static const PaymentMethod HOTRECHARGE = PaymentMethod._(2, 'HOTRECHARGE');
  static const PaymentMethod STRIPE = PaymentMethod._(3, 'STRIPE');
  static const PaymentMethod BALANCE = PaymentMethod._(4, 'BALANCE');

  static const $core.List<PaymentMethod> values = <PaymentMethod> [
    PAYPAL,
    PAYNOW,
    HOTRECHARGE,
    STRIPE,
    BALANCE,
  ];

  static final $core.Map<$core.int, PaymentMethod> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PaymentMethod valueOf($core.int value) => _byValue[value];

  const PaymentMethod._($core.int v, $core.String n) : super(v, n);
}

