///
//  Generated code. Do not modify.
//  source: lib/src/communication/protos/payments.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'payments.pbenum.dart';

export 'payments.pbenum.dart';

class PaymentDetails extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PaymentDetails', package: const $pb.PackageName('payment'), createEmptyInstance: create)
    ..aOS(1, 'transactionID', protoName: 'transactionID')
    ..aOS(2, 'hash')
    ..hasRequiredFields = false
  ;

  PaymentDetails._() : super();
  factory PaymentDetails() => create();
  factory PaymentDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaymentDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PaymentDetails clone() => PaymentDetails()..mergeFromMessage(this);
  PaymentDetails copyWith(void Function(PaymentDetails) updates) => super.copyWith((message) => updates(message as PaymentDetails));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PaymentDetails create() => PaymentDetails._();
  PaymentDetails createEmptyInstance() => create();
  static $pb.PbList<PaymentDetails> createRepeated() => $pb.PbList<PaymentDetails>();
  @$core.pragma('dart2js:noInline')
  static PaymentDetails getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaymentDetails>(create);
  static PaymentDetails _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionID => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionID() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get hash => $_getSZ(1);
  @$pb.TagNumber(2)
  set hash($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearHash() => clearField(2);
}

class Payment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Payment', package: const $pb.PackageName('payment'), createEmptyInstance: create)
    ..aOS(1, 'username')
    ..aOS(2, 'contact')
    ..aOS(3, 'email')
    ..aOS(4, 'currency')
    ..a<$core.double>(5, 'amount', $pb.PbFieldType.OD)
    ..aOS(6, 'domain')
    ..e<PaymentStatus>(7, 'status', $pb.PbFieldType.OE, defaultOrMaker: PaymentStatus.SUCCESS, valueOf: PaymentStatus.valueOf, enumValues: PaymentStatus.values)
    ..e<PaymentMethod>(8, 'method', $pb.PbFieldType.OE, defaultOrMaker: PaymentMethod.PAYPAL, valueOf: PaymentMethod.valueOf, enumValues: PaymentMethod.values)
    ..aOM<PaymentDetails>(9, 'details', subBuilder: PaymentDetails.create)
    ..aOS(999, 'created')
    ..hasRequiredFields = false
  ;

  Payment._() : super();
  factory Payment() => create();
  factory Payment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Payment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Payment clone() => Payment()..mergeFromMessage(this);
  Payment copyWith(void Function(Payment) updates) => super.copyWith((message) => updates(message as Payment));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Payment create() => Payment._();
  Payment createEmptyInstance() => create();
  static $pb.PbList<Payment> createRepeated() => $pb.PbList<Payment>();
  @$core.pragma('dart2js:noInline')
  static Payment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payment>(create);
  static Payment _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get contact => $_getSZ(1);
  @$pb.TagNumber(2)
  set contact($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContact() => $_has(1);
  @$pb.TagNumber(2)
  void clearContact() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get amount => $_getN(4);
  @$pb.TagNumber(5)
  set amount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get domain => $_getSZ(5);
  @$pb.TagNumber(6)
  set domain($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDomain() => $_has(5);
  @$pb.TagNumber(6)
  void clearDomain() => clearField(6);

  @$pb.TagNumber(7)
  PaymentStatus get status => $_getN(6);
  @$pb.TagNumber(7)
  set status(PaymentStatus v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => clearField(7);

  @$pb.TagNumber(8)
  PaymentMethod get method => $_getN(7);
  @$pb.TagNumber(8)
  set method(PaymentMethod v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasMethod() => $_has(7);
  @$pb.TagNumber(8)
  void clearMethod() => clearField(8);

  @$pb.TagNumber(9)
  PaymentDetails get details => $_getN(8);
  @$pb.TagNumber(9)
  set details(PaymentDetails v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasDetails() => $_has(8);
  @$pb.TagNumber(9)
  void clearDetails() => clearField(9);
  @$pb.TagNumber(9)
  PaymentDetails ensureDetails() => $_ensure(8);

  @$pb.TagNumber(999)
  $core.String get created => $_getSZ(9);
  @$pb.TagNumber(999)
  set created($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(999)
  $core.bool hasCreated() => $_has(9);
  @$pb.TagNumber(999)
  void clearCreated() => clearField(999);
}

class paymentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('paymentRequest', package: const $pb.PackageName('payment'), createEmptyInstance: create)
    ..aOM<Payment>(1, 'payment', subBuilder: Payment.create)
    ..aOS(2, 'nonce')
    ..hasRequiredFields = false
  ;

  paymentRequest._() : super();
  factory paymentRequest() => create();
  factory paymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory paymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  paymentRequest clone() => paymentRequest()..mergeFromMessage(this);
  paymentRequest copyWith(void Function(paymentRequest) updates) => super.copyWith((message) => updates(message as paymentRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static paymentRequest create() => paymentRequest._();
  paymentRequest createEmptyInstance() => create();
  static $pb.PbList<paymentRequest> createRepeated() => $pb.PbList<paymentRequest>();
  @$core.pragma('dart2js:noInline')
  static paymentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<paymentRequest>(create);
  static paymentRequest _defaultInstance;

  @$pb.TagNumber(1)
  Payment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(Payment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => clearField(1);
  @$pb.TagNumber(1)
  Payment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get nonce => $_getSZ(1);
  @$pb.TagNumber(2)
  set nonce($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNonce() => $_has(1);
  @$pb.TagNumber(2)
  void clearNonce() => clearField(2);
}

class infoPayment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('infoPayment', package: const $pb.PackageName('payment'), createEmptyInstance: create)
    ..aOS(1, 'contact')
    ..hasRequiredFields = false
  ;

  infoPayment._() : super();
  factory infoPayment() => create();
  factory infoPayment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory infoPayment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  infoPayment clone() => infoPayment()..mergeFromMessage(this);
  infoPayment copyWith(void Function(infoPayment) updates) => super.copyWith((message) => updates(message as infoPayment));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static infoPayment create() => infoPayment._();
  infoPayment createEmptyInstance() => create();
  static $pb.PbList<infoPayment> createRepeated() => $pb.PbList<infoPayment>();
  @$core.pragma('dart2js:noInline')
  static infoPayment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<infoPayment>(create);
  static infoPayment _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contact => $_getSZ(0);
  @$pb.TagNumber(1)
  set contact($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContact() => $_has(0);
  @$pb.TagNumber(1)
  void clearContact() => clearField(1);
}

class detailsPayment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('detailsPayment', package: const $pb.PackageName('payment'), createEmptyInstance: create)
    ..aOS(1, 'result')
    ..hasRequiredFields = false
  ;

  detailsPayment._() : super();
  factory detailsPayment() => create();
  factory detailsPayment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory detailsPayment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  detailsPayment clone() => detailsPayment()..mergeFromMessage(this);
  detailsPayment copyWith(void Function(detailsPayment) updates) => super.copyWith((message) => updates(message as detailsPayment));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static detailsPayment create() => detailsPayment._();
  detailsPayment createEmptyInstance() => create();
  static $pb.PbList<detailsPayment> createRepeated() => $pb.PbList<detailsPayment>();
  @$core.pragma('dart2js:noInline')
  static detailsPayment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<detailsPayment>(create);
  static detailsPayment _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
}

