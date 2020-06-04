///
//  Generated code. Do not modify.
//  source: lib/src/communication/protos/users.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'users.pb.dart' as $1;
export 'users.pb.dart';

class userServiceClient extends $grpc.Client {
  static final _$loginUser = $grpc.ClientMethod<$1.loginUser, $1.detailsUser>(
      '/users.userService/LoginUser',
      ($1.loginUser value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.detailsUser.fromBuffer(value));
  static final _$verifyUser = $grpc.ClientMethod<$1.verifyUser, $1.detailsUser>(
      '/users.userService/VerifyUser',
      ($1.verifyUser value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.detailsUser.fromBuffer(value));
  static final _$createUser = $grpc.ClientMethod<$1.createUser, $1.detailsUser>(
      '/users.userService/CreateUser',
      ($1.createUser value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.detailsUser.fromBuffer(value));
  static final _$removeUser = $grpc.ClientMethod<$1.infoUser, $1.detailsUser>(
      '/users.userService/RemoveUser',
      ($1.infoUser value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.detailsUser.fromBuffer(value));
  static final _$updateUser = $grpc.ClientMethod<$1.updateUser, $1.detailsUser>(
      '/users.userService/UpdateUser',
      ($1.updateUser value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.detailsUser.fromBuffer(value));
  static final _$displayUser = $grpc.ClientMethod<$1.infoUser, $1.User>(
      '/users.userService/DisplayUser',
      ($1.infoUser value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.User.fromBuffer(value));
  static final _$listUsers = $grpc.ClientMethod<$1.infoUser, $1.User>(
      '/users.userService/ListUsers',
      ($1.infoUser value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.User.fromBuffer(value));
  static final _$getBalance = $grpc.ClientMethod<$1.infoUser, $1.Account>(
      '/users.userService/GetBalance',
      ($1.infoUser value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Account.fromBuffer(value));
  static final _$updateBalance = $grpc.ClientMethod<$1.Account, $1.detailsUser>(
      '/users.userService/UpdateBalance',
      ($1.Account value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.detailsUser.fromBuffer(value));
  static final _$passwordReset =
      $grpc.ClientMethod<$1.updateUser, $1.detailsUser>(
          '/users.userService/PasswordReset',
          ($1.updateUser value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.detailsUser.fromBuffer(value));
  static final _$setMerchant =
      $grpc.ClientMethod<$1.updateUser, $1.detailsUser>(
          '/users.userService/SetMerchant',
          ($1.updateUser value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.detailsUser.fromBuffer(value));
  static final _$addBeneficiary =
      $grpc.ClientMethod<$1.addBeneiciary, $1.detailsUser>(
          '/users.userService/AddBeneficiary',
          ($1.addBeneiciary value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.detailsUser.fromBuffer(value));

  userServiceClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$1.detailsUser> loginUser($1.loginUser request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$loginUser, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.detailsUser> verifyUser($1.verifyUser request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$verifyUser, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.detailsUser> createUser($1.createUser request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$createUser, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.detailsUser> removeUser($1.infoUser request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$removeUser, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.detailsUser> updateUser($1.updateUser request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$updateUser, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.User> displayUser($1.infoUser request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$displayUser, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseStream<$1.User> listUsers($1.infoUser request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$listUsers, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseStream(call);
  }

  $grpc.ResponseFuture<$1.Account> getBalance($1.infoUser request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getBalance, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.detailsUser> updateBalance($1.Account request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$updateBalance, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.detailsUser> passwordReset($1.updateUser request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$passwordReset, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.detailsUser> setMerchant($1.updateUser request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$setMerchant, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.detailsUser> addBeneficiary($1.addBeneiciary request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$addBeneficiary, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class userServiceBase extends $grpc.Service {
  $core.String get $name => 'users.userService';

  userServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.loginUser, $1.detailsUser>(
        'LoginUser',
        loginUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.loginUser.fromBuffer(value),
        ($1.detailsUser value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.verifyUser, $1.detailsUser>(
        'VerifyUser',
        verifyUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.verifyUser.fromBuffer(value),
        ($1.detailsUser value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.createUser, $1.detailsUser>(
        'CreateUser',
        createUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.createUser.fromBuffer(value),
        ($1.detailsUser value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.infoUser, $1.detailsUser>(
        'RemoveUser',
        removeUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.infoUser.fromBuffer(value),
        ($1.detailsUser value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.updateUser, $1.detailsUser>(
        'UpdateUser',
        updateUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.updateUser.fromBuffer(value),
        ($1.detailsUser value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.infoUser, $1.User>(
        'DisplayUser',
        displayUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.infoUser.fromBuffer(value),
        ($1.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.infoUser, $1.User>(
        'ListUsers',
        listUsers_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.infoUser.fromBuffer(value),
        ($1.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.infoUser, $1.Account>(
        'GetBalance',
        getBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.infoUser.fromBuffer(value),
        ($1.Account value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Account, $1.detailsUser>(
        'UpdateBalance',
        updateBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Account.fromBuffer(value),
        ($1.detailsUser value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.updateUser, $1.detailsUser>(
        'PasswordReset',
        passwordReset_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.updateUser.fromBuffer(value),
        ($1.detailsUser value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.updateUser, $1.detailsUser>(
        'SetMerchant',
        setMerchant_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.updateUser.fromBuffer(value),
        ($1.detailsUser value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.addBeneiciary, $1.detailsUser>(
        'AddBeneficiary',
        addBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.addBeneiciary.fromBuffer(value),
        ($1.detailsUser value) => value.writeToBuffer()));
  }

  $async.Future<$1.detailsUser> loginUser_Pre(
      $grpc.ServiceCall call, $async.Future<$1.loginUser> request) async {
    return loginUser(call, await request);
  }

  $async.Future<$1.detailsUser> verifyUser_Pre(
      $grpc.ServiceCall call, $async.Future<$1.verifyUser> request) async {
    return verifyUser(call, await request);
  }

  $async.Future<$1.detailsUser> createUser_Pre(
      $grpc.ServiceCall call, $async.Future<$1.createUser> request) async {
    return createUser(call, await request);
  }

  $async.Future<$1.detailsUser> removeUser_Pre(
      $grpc.ServiceCall call, $async.Future<$1.infoUser> request) async {
    return removeUser(call, await request);
  }

  $async.Future<$1.detailsUser> updateUser_Pre(
      $grpc.ServiceCall call, $async.Future<$1.updateUser> request) async {
    return updateUser(call, await request);
  }

  $async.Future<$1.User> displayUser_Pre(
      $grpc.ServiceCall call, $async.Future<$1.infoUser> request) async {
    return displayUser(call, await request);
  }

  $async.Stream<$1.User> listUsers_Pre(
      $grpc.ServiceCall call, $async.Future<$1.infoUser> request) async* {
    yield* listUsers(call, await request);
  }

  $async.Future<$1.Account> getBalance_Pre(
      $grpc.ServiceCall call, $async.Future<$1.infoUser> request) async {
    return getBalance(call, await request);
  }

  $async.Future<$1.detailsUser> updateBalance_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Account> request) async {
    return updateBalance(call, await request);
  }

  $async.Future<$1.detailsUser> passwordReset_Pre(
      $grpc.ServiceCall call, $async.Future<$1.updateUser> request) async {
    return passwordReset(call, await request);
  }

  $async.Future<$1.detailsUser> setMerchant_Pre(
      $grpc.ServiceCall call, $async.Future<$1.updateUser> request) async {
    return setMerchant(call, await request);
  }

  $async.Future<$1.detailsUser> addBeneficiary_Pre(
      $grpc.ServiceCall call, $async.Future<$1.addBeneiciary> request) async {
    return addBeneficiary(call, await request);
  }

  $async.Future<$1.detailsUser> loginUser(
      $grpc.ServiceCall call, $1.loginUser request);
  $async.Future<$1.detailsUser> verifyUser(
      $grpc.ServiceCall call, $1.verifyUser request);
  $async.Future<$1.detailsUser> createUser(
      $grpc.ServiceCall call, $1.createUser request);
  $async.Future<$1.detailsUser> removeUser(
      $grpc.ServiceCall call, $1.infoUser request);
  $async.Future<$1.detailsUser> updateUser(
      $grpc.ServiceCall call, $1.updateUser request);
  $async.Future<$1.User> displayUser(
      $grpc.ServiceCall call, $1.infoUser request);
  $async.Stream<$1.User> listUsers($grpc.ServiceCall call, $1.infoUser request);
  $async.Future<$1.Account> getBalance(
      $grpc.ServiceCall call, $1.infoUser request);
  $async.Future<$1.detailsUser> updateBalance(
      $grpc.ServiceCall call, $1.Account request);
  $async.Future<$1.detailsUser> passwordReset(
      $grpc.ServiceCall call, $1.updateUser request);
  $async.Future<$1.detailsUser> setMerchant(
      $grpc.ServiceCall call, $1.updateUser request);
  $async.Future<$1.detailsUser> addBeneficiary(
      $grpc.ServiceCall call, $1.addBeneiciary request);
}
