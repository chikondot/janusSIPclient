///
//  Generated code. Do not modify.
//  source: lib/src/communication/protos/payments.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'payments.pb.dart' as $0;
export 'payments.pb.dart';

class payServiceClient extends $grpc.Client {
  static final _$getPayPalToken =
      $grpc.ClientMethod<$0.detailsPayment, $0.detailsPayment>(
          '/payment.payService/GetPayPalToken',
          ($0.detailsPayment value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.detailsPayment.fromBuffer(value));
  static final _$makePayPalPayment =
      $grpc.ClientMethod<$0.paymentRequest, $0.detailsPayment>(
          '/payment.payService/MakePayPalPayment',
          ($0.paymentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.detailsPayment.fromBuffer(value));
  static final _$makeStripePayment =
      $grpc.ClientMethod<$0.paymentRequest, $0.detailsPayment>(
          '/payment.payService/MakeStripePayment',
          ($0.paymentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.detailsPayment.fromBuffer(value));
  static final _$makePayNowPayment =
      $grpc.ClientMethod<$0.paymentRequest, $0.detailsPayment>(
          '/payment.payService/MakePayNowPayment',
          ($0.paymentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.detailsPayment.fromBuffer(value));
  static final _$makeAirtimePayment =
      $grpc.ClientMethod<$0.paymentRequest, $0.detailsPayment>(
          '/payment.payService/MakeAirtimePayment',
          ($0.paymentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.detailsPayment.fromBuffer(value));
  static final _$makeGurooPayment =
      $grpc.ClientMethod<$0.paymentRequest, $0.detailsPayment>(
          '/payment.payService/MakeGurooPayment',
          ($0.paymentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.detailsPayment.fromBuffer(value));
  static final _$getPayment = $grpc.ClientMethod<$0.infoPayment, $0.Payment>(
      '/payment.payService/GetPayment',
      ($0.infoPayment value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Payment.fromBuffer(value));
  static final _$listPayment = $grpc.ClientMethod<$0.infoPayment, $0.Payment>(
      '/payment.payService/ListPayment',
      ($0.infoPayment value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Payment.fromBuffer(value));

  payServiceClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.detailsPayment> getPayPalToken(
      $0.detailsPayment request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getPayPalToken, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.detailsPayment> makePayPalPayment(
      $0.paymentRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$makePayPalPayment, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.detailsPayment> makeStripePayment(
      $0.paymentRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$makeStripePayment, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.detailsPayment> makePayNowPayment(
      $0.paymentRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$makePayNowPayment, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.detailsPayment> makeAirtimePayment(
      $0.paymentRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$makeAirtimePayment, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.detailsPayment> makeGurooPayment(
      $0.paymentRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$makeGurooPayment, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.Payment> getPayment($0.infoPayment request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getPayment, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseStream<$0.Payment> listPayment($0.infoPayment request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$listPayment, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseStream(call);
  }
}

abstract class payServiceBase extends $grpc.Service {
  $core.String get $name => 'payment.payService';

  payServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.detailsPayment, $0.detailsPayment>(
        'GetPayPalToken',
        getPayPalToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.detailsPayment.fromBuffer(value),
        ($0.detailsPayment value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.paymentRequest, $0.detailsPayment>(
        'MakePayPalPayment',
        makePayPalPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.paymentRequest.fromBuffer(value),
        ($0.detailsPayment value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.paymentRequest, $0.detailsPayment>(
        'MakeStripePayment',
        makeStripePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.paymentRequest.fromBuffer(value),
        ($0.detailsPayment value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.paymentRequest, $0.detailsPayment>(
        'MakePayNowPayment',
        makePayNowPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.paymentRequest.fromBuffer(value),
        ($0.detailsPayment value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.paymentRequest, $0.detailsPayment>(
        'MakeAirtimePayment',
        makeAirtimePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.paymentRequest.fromBuffer(value),
        ($0.detailsPayment value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.paymentRequest, $0.detailsPayment>(
        'MakeGurooPayment',
        makeGurooPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.paymentRequest.fromBuffer(value),
        ($0.detailsPayment value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.infoPayment, $0.Payment>(
        'GetPayment',
        getPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.infoPayment.fromBuffer(value),
        ($0.Payment value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.infoPayment, $0.Payment>(
        'ListPayment',
        listPayment_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.infoPayment.fromBuffer(value),
        ($0.Payment value) => value.writeToBuffer()));
  }

  $async.Future<$0.detailsPayment> getPayPalToken_Pre(
      $grpc.ServiceCall call, $async.Future<$0.detailsPayment> request) async {
    return getPayPalToken(call, await request);
  }

  $async.Future<$0.detailsPayment> makePayPalPayment_Pre(
      $grpc.ServiceCall call, $async.Future<$0.paymentRequest> request) async {
    return makePayPalPayment(call, await request);
  }

  $async.Future<$0.detailsPayment> makeStripePayment_Pre(
      $grpc.ServiceCall call, $async.Future<$0.paymentRequest> request) async {
    return makeStripePayment(call, await request);
  }

  $async.Future<$0.detailsPayment> makePayNowPayment_Pre(
      $grpc.ServiceCall call, $async.Future<$0.paymentRequest> request) async {
    return makePayNowPayment(call, await request);
  }

  $async.Future<$0.detailsPayment> makeAirtimePayment_Pre(
      $grpc.ServiceCall call, $async.Future<$0.paymentRequest> request) async {
    return makeAirtimePayment(call, await request);
  }

  $async.Future<$0.detailsPayment> makeGurooPayment_Pre(
      $grpc.ServiceCall call, $async.Future<$0.paymentRequest> request) async {
    return makeGurooPayment(call, await request);
  }

  $async.Future<$0.Payment> getPayment_Pre(
      $grpc.ServiceCall call, $async.Future<$0.infoPayment> request) async {
    return getPayment(call, await request);
  }

  $async.Stream<$0.Payment> listPayment_Pre(
      $grpc.ServiceCall call, $async.Future<$0.infoPayment> request) async* {
    yield* listPayment(call, await request);
  }

  $async.Future<$0.detailsPayment> getPayPalToken(
      $grpc.ServiceCall call, $0.detailsPayment request);
  $async.Future<$0.detailsPayment> makePayPalPayment(
      $grpc.ServiceCall call, $0.paymentRequest request);
  $async.Future<$0.detailsPayment> makeStripePayment(
      $grpc.ServiceCall call, $0.paymentRequest request);
  $async.Future<$0.detailsPayment> makePayNowPayment(
      $grpc.ServiceCall call, $0.paymentRequest request);
  $async.Future<$0.detailsPayment> makeAirtimePayment(
      $grpc.ServiceCall call, $0.paymentRequest request);
  $async.Future<$0.detailsPayment> makeGurooPayment(
      $grpc.ServiceCall call, $0.paymentRequest request);
  $async.Future<$0.Payment> getPayment(
      $grpc.ServiceCall call, $0.infoPayment request);
  $async.Stream<$0.Payment> listPayment(
      $grpc.ServiceCall call, $0.infoPayment request);
}
