///
//  Generated code. Do not modify.
//  source: lib/src/communication/protos/users.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'users.pbenum.dart';

export 'users.pbenum.dart';

class Balance extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Balance', package: const $pb.PackageName('users'), createEmptyInstance: create)
    ..aOS(1, 'currency')
    ..a<$core.double>(2, 'amount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Balance._() : super();
  factory Balance() => create();
  factory Balance.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Balance.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Balance clone() => Balance()..mergeFromMessage(this);
  Balance copyWith(void Function(Balance) updates) => super.copyWith((message) => updates(message as Balance));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Balance create() => Balance._();
  Balance createEmptyInstance() => create();
  static $pb.PbList<Balance> createRepeated() => $pb.PbList<Balance>();
  @$core.pragma('dart2js:noInline')
  static Balance getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Balance>(create);
  static Balance _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get currency => $_getSZ(0);
  @$pb.TagNumber(1)
  set currency($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrency() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);
}

class Beneficiaries extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Beneficiaries', package: const $pb.PackageName('users'), createEmptyInstance: create)
    ..aOS(1, 'user')
    ..hasRequiredFields = false
  ;

  Beneficiaries._() : super();
  factory Beneficiaries() => create();
  factory Beneficiaries.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Beneficiaries.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Beneficiaries clone() => Beneficiaries()..mergeFromMessage(this);
  Beneficiaries copyWith(void Function(Beneficiaries) updates) => super.copyWith((message) => updates(message as Beneficiaries));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Beneficiaries create() => Beneficiaries._();
  Beneficiaries createEmptyInstance() => create();
  static $pb.PbList<Beneficiaries> createRepeated() => $pb.PbList<Beneficiaries>();
  @$core.pragma('dart2js:noInline')
  static Beneficiaries getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Beneficiaries>(create);
  static Beneficiaries _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get user => $_getSZ(0);
  @$pb.TagNumber(1)
  set user($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
}

class Additional extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Additional', package: const $pb.PackageName('users'), createEmptyInstance: create)
    ..aOS(1, 'identity')
    ..aOS(2, 'nationality')
    ..aOS(3, 'dob')
    ..aOS(4, 'gender')
    ..aOS(5, 'banking')
    ..aOS(6, 'occupation')
    ..aOS(7, 'employer')
    ..aOS(8, 'employerAdress', protoName: 'employerAdress')
    ..e<UserStatus>(9, 'status', $pb.PbFieldType.OE, defaultOrMaker: UserStatus.SUSPENDED, valueOf: UserStatus.valueOf, enumValues: UserStatus.values)
    ..pc<Beneficiaries>(10, 'beneficiaries', $pb.PbFieldType.PM, subBuilder: Beneficiaries.create)
    ..hasRequiredFields = false
  ;

  Additional._() : super();
  factory Additional() => create();
  factory Additional.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Additional.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Additional clone() => Additional()..mergeFromMessage(this);
  Additional copyWith(void Function(Additional) updates) => super.copyWith((message) => updates(message as Additional));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Additional create() => Additional._();
  Additional createEmptyInstance() => create();
  static $pb.PbList<Additional> createRepeated() => $pb.PbList<Additional>();
  @$core.pragma('dart2js:noInline')
  static Additional getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Additional>(create);
  static Additional _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get identity => $_getSZ(0);
  @$pb.TagNumber(1)
  set identity($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIdentity() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdentity() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get nationality => $_getSZ(1);
  @$pb.TagNumber(2)
  set nationality($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNationality() => $_has(1);
  @$pb.TagNumber(2)
  void clearNationality() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get dob => $_getSZ(2);
  @$pb.TagNumber(3)
  set dob($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDob() => $_has(2);
  @$pb.TagNumber(3)
  void clearDob() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get gender => $_getSZ(3);
  @$pb.TagNumber(4)
  set gender($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasGender() => $_has(3);
  @$pb.TagNumber(4)
  void clearGender() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get banking => $_getSZ(4);
  @$pb.TagNumber(5)
  set banking($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBanking() => $_has(4);
  @$pb.TagNumber(5)
  void clearBanking() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get occupation => $_getSZ(5);
  @$pb.TagNumber(6)
  set occupation($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasOccupation() => $_has(5);
  @$pb.TagNumber(6)
  void clearOccupation() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get employer => $_getSZ(6);
  @$pb.TagNumber(7)
  set employer($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasEmployer() => $_has(6);
  @$pb.TagNumber(7)
  void clearEmployer() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get employerAdress => $_getSZ(7);
  @$pb.TagNumber(8)
  set employerAdress($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasEmployerAdress() => $_has(7);
  @$pb.TagNumber(8)
  void clearEmployerAdress() => clearField(8);

  @$pb.TagNumber(9)
  UserStatus get status => $_getN(8);
  @$pb.TagNumber(9)
  set status(UserStatus v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => clearField(9);

  @$pb.TagNumber(10)
  $core.List<Beneficiaries> get beneficiaries => $_getList(9);
}

class Account extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Account', package: const $pb.PackageName('users'), createEmptyInstance: create)
    ..aOS(1, 'Id')
    ..a<$core.double>(2, 'balance', $pb.PbFieldType.OD)
    ..aOS(3, 'modified')
    ..hasRequiredFields = false
  ;

  Account._() : super();
  factory Account() => create();
  factory Account.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Account.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Account clone() => Account()..mergeFromMessage(this);
  Account copyWith(void Function(Account) updates) => super.copyWith((message) => updates(message as Account));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Account create() => Account._();
  Account createEmptyInstance() => create();
  static $pb.PbList<Account> createRepeated() => $pb.PbList<Account>();
  @$core.pragma('dart2js:noInline')
  static Account getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Account>(create);
  static Account _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get balance => $_getN(1);
  @$pb.TagNumber(2)
  set balance($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get modified => $_getSZ(2);
  @$pb.TagNumber(3)
  set modified($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasModified() => $_has(2);
  @$pb.TagNumber(3)
  void clearModified() => clearField(3);
}

class User extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('User', package: const $pb.PackageName('users'), createEmptyInstance: create)
    ..aOS(1, 'username')
    ..aOS(2, 'contact')
    ..aOS(3, 'email')
    ..aOS(4, 'address')
    ..aOS(5, 'domain')
    ..aOS(6, 'password')
    ..a<$core.double>(7, 'balance', $pb.PbFieldType.OD)
    ..aInt64(8, 'reference')
    ..aOM<Additional>(9, 'additional', subBuilder: Additional.create)
    ..aOS(997, 'created')
    ..aOS(998, 'modified')
    ..aOS(999, 'verification')
    ..hasRequiredFields = false
  ;

  User._() : super();
  factory User() => create();
  factory User.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory User.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  User clone() => User()..mergeFromMessage(this);
  User copyWith(void Function(User) updates) => super.copyWith((message) => updates(message as User));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  User createEmptyInstance() => create();
  static $pb.PbList<User> createRepeated() => $pb.PbList<User>();
  @$core.pragma('dart2js:noInline')
  static User getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User _defaultInstance;

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
  $core.String get address => $_getSZ(3);
  @$pb.TagNumber(4)
  set address($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAddress() => $_has(3);
  @$pb.TagNumber(4)
  void clearAddress() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get domain => $_getSZ(4);
  @$pb.TagNumber(5)
  set domain($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDomain() => $_has(4);
  @$pb.TagNumber(5)
  void clearDomain() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get password => $_getSZ(5);
  @$pb.TagNumber(6)
  set password($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPassword() => $_has(5);
  @$pb.TagNumber(6)
  void clearPassword() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get balance => $_getN(6);
  @$pb.TagNumber(7)
  set balance($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasBalance() => $_has(6);
  @$pb.TagNumber(7)
  void clearBalance() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get reference => $_getI64(7);
  @$pb.TagNumber(8)
  set reference($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasReference() => $_has(7);
  @$pb.TagNumber(8)
  void clearReference() => clearField(8);

  @$pb.TagNumber(9)
  Additional get additional => $_getN(8);
  @$pb.TagNumber(9)
  set additional(Additional v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasAdditional() => $_has(8);
  @$pb.TagNumber(9)
  void clearAdditional() => clearField(9);
  @$pb.TagNumber(9)
  Additional ensureAdditional() => $_ensure(8);

  @$pb.TagNumber(997)
  $core.String get created => $_getSZ(9);
  @$pb.TagNumber(997)
  set created($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(997)
  $core.bool hasCreated() => $_has(9);
  @$pb.TagNumber(997)
  void clearCreated() => clearField(997);

  @$pb.TagNumber(998)
  $core.String get modified => $_getSZ(10);
  @$pb.TagNumber(998)
  set modified($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(998)
  $core.bool hasModified() => $_has(10);
  @$pb.TagNumber(998)
  void clearModified() => clearField(998);

  @$pb.TagNumber(999)
  $core.String get verification => $_getSZ(11);
  @$pb.TagNumber(999)
  set verification($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(999)
  $core.bool hasVerification() => $_has(11);
  @$pb.TagNumber(999)
  void clearVerification() => clearField(999);
}

class verifyUser extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('verifyUser', package: const $pb.PackageName('users'), createEmptyInstance: create)
    ..aOS(1, 'contact')
    ..hasRequiredFields = false
  ;

  verifyUser._() : super();
  factory verifyUser() => create();
  factory verifyUser.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory verifyUser.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  verifyUser clone() => verifyUser()..mergeFromMessage(this);
  verifyUser copyWith(void Function(verifyUser) updates) => super.copyWith((message) => updates(message as verifyUser));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static verifyUser create() => verifyUser._();
  verifyUser createEmptyInstance() => create();
  static $pb.PbList<verifyUser> createRepeated() => $pb.PbList<verifyUser>();
  @$core.pragma('dart2js:noInline')
  static verifyUser getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<verifyUser>(create);
  static verifyUser _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contact => $_getSZ(0);
  @$pb.TagNumber(1)
  set contact($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContact() => $_has(0);
  @$pb.TagNumber(1)
  void clearContact() => clearField(1);
}

class loginUser extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('loginUser', package: const $pb.PackageName('users'), createEmptyInstance: create)
    ..aOS(1, 'username')
    ..aOS(2, 'domain')
    ..aOS(3, 'password')
    ..hasRequiredFields = false
  ;

  loginUser._() : super();
  factory loginUser() => create();
  factory loginUser.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory loginUser.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  loginUser clone() => loginUser()..mergeFromMessage(this);
  loginUser copyWith(void Function(loginUser) updates) => super.copyWith((message) => updates(message as loginUser));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static loginUser create() => loginUser._();
  loginUser createEmptyInstance() => create();
  static $pb.PbList<loginUser> createRepeated() => $pb.PbList<loginUser>();
  @$core.pragma('dart2js:noInline')
  static loginUser getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<loginUser>(create);
  static loginUser _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get domain => $_getSZ(1);
  @$pb.TagNumber(2)
  set domain($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDomain() => $_has(1);
  @$pb.TagNumber(2)
  void clearDomain() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get password => $_getSZ(2);
  @$pb.TagNumber(3)
  set password($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPassword() => $_has(2);
  @$pb.TagNumber(3)
  void clearPassword() => clearField(3);
}

class createUser extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('createUser', package: const $pb.PackageName('users'), createEmptyInstance: create)
    ..aOM<User>(1, 'user', subBuilder: User.create)
    ..hasRequiredFields = false
  ;

  createUser._() : super();
  factory createUser() => create();
  factory createUser.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory createUser.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  createUser clone() => createUser()..mergeFromMessage(this);
  createUser copyWith(void Function(createUser) updates) => super.copyWith((message) => updates(message as createUser));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static createUser create() => createUser._();
  createUser createEmptyInstance() => create();
  static $pb.PbList<createUser> createRepeated() => $pb.PbList<createUser>();
  @$core.pragma('dart2js:noInline')
  static createUser getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<createUser>(create);
  static createUser _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

class infoUser extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('infoUser', package: const $pb.PackageName('users'), createEmptyInstance: create)
    ..aOS(1, 'username')
    ..aOS(2, 'domain')
    ..hasRequiredFields = false
  ;

  infoUser._() : super();
  factory infoUser() => create();
  factory infoUser.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory infoUser.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  infoUser clone() => infoUser()..mergeFromMessage(this);
  infoUser copyWith(void Function(infoUser) updates) => super.copyWith((message) => updates(message as infoUser));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static infoUser create() => infoUser._();
  infoUser createEmptyInstance() => create();
  static $pb.PbList<infoUser> createRepeated() => $pb.PbList<infoUser>();
  @$core.pragma('dart2js:noInline')
  static infoUser getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<infoUser>(create);
  static infoUser _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get domain => $_getSZ(1);
  @$pb.TagNumber(2)
  set domain($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDomain() => $_has(1);
  @$pb.TagNumber(2)
  void clearDomain() => clearField(2);
}

class updateUser extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('updateUser', package: const $pb.PackageName('users'), createEmptyInstance: create)
    ..aOS(1, 'username')
    ..aOS(2, 'contact')
    ..aOS(3, 'email')
    ..aOS(4, 'address')
    ..aOS(5, 'password')
    ..aOS(6, 'domain')
    ..aOM<Additional>(7, 'additional', subBuilder: Additional.create)
    ..hasRequiredFields = false
  ;

  updateUser._() : super();
  factory updateUser() => create();
  factory updateUser.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory updateUser.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  updateUser clone() => updateUser()..mergeFromMessage(this);
  updateUser copyWith(void Function(updateUser) updates) => super.copyWith((message) => updates(message as updateUser));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static updateUser create() => updateUser._();
  updateUser createEmptyInstance() => create();
  static $pb.PbList<updateUser> createRepeated() => $pb.PbList<updateUser>();
  @$core.pragma('dart2js:noInline')
  static updateUser getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<updateUser>(create);
  static updateUser _defaultInstance;

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
  $core.String get address => $_getSZ(3);
  @$pb.TagNumber(4)
  set address($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAddress() => $_has(3);
  @$pb.TagNumber(4)
  void clearAddress() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get password => $_getSZ(4);
  @$pb.TagNumber(5)
  set password($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPassword() => $_has(4);
  @$pb.TagNumber(5)
  void clearPassword() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get domain => $_getSZ(5);
  @$pb.TagNumber(6)
  set domain($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDomain() => $_has(5);
  @$pb.TagNumber(6)
  void clearDomain() => clearField(6);

  @$pb.TagNumber(7)
  Additional get additional => $_getN(6);
  @$pb.TagNumber(7)
  set additional(Additional v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasAdditional() => $_has(6);
  @$pb.TagNumber(7)
  void clearAdditional() => clearField(7);
  @$pb.TagNumber(7)
  Additional ensureAdditional() => $_ensure(6);
}

class detailsUser extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('detailsUser', package: const $pb.PackageName('users'), createEmptyInstance: create)
    ..aOS(1, 'result')
    ..aOS(2, 'Id')
    ..aOS(3, 'username')
    ..aOS(4, 'contact')
    ..aOS(5, 'email')
    ..aOS(6, 'address')
    ..hasRequiredFields = false
  ;

  detailsUser._() : super();
  factory detailsUser() => create();
  factory detailsUser.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory detailsUser.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  detailsUser clone() => detailsUser()..mergeFromMessage(this);
  detailsUser copyWith(void Function(detailsUser) updates) => super.copyWith((message) => updates(message as detailsUser));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static detailsUser create() => detailsUser._();
  detailsUser createEmptyInstance() => create();
  static $pb.PbList<detailsUser> createRepeated() => $pb.PbList<detailsUser>();
  @$core.pragma('dart2js:noInline')
  static detailsUser getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<detailsUser>(create);
  static detailsUser _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get username => $_getSZ(2);
  @$pb.TagNumber(3)
  set username($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUsername() => $_has(2);
  @$pb.TagNumber(3)
  void clearUsername() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get contact => $_getSZ(3);
  @$pb.TagNumber(4)
  set contact($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasContact() => $_has(3);
  @$pb.TagNumber(4)
  void clearContact() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get email => $_getSZ(4);
  @$pb.TagNumber(5)
  set email($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmail() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get address => $_getSZ(5);
  @$pb.TagNumber(6)
  set address($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAddress() => $_has(5);
  @$pb.TagNumber(6)
  void clearAddress() => clearField(6);
}

class addBeneiciary extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('addBeneiciary', package: const $pb.PackageName('users'), createEmptyInstance: create)
    ..aOS(1, 'username')
    ..aOM<Beneficiaries>(2, 'beneiciary', subBuilder: Beneficiaries.create)
    ..hasRequiredFields = false
  ;

  addBeneiciary._() : super();
  factory addBeneiciary() => create();
  factory addBeneiciary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory addBeneiciary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  addBeneiciary clone() => addBeneiciary()..mergeFromMessage(this);
  addBeneiciary copyWith(void Function(addBeneiciary) updates) => super.copyWith((message) => updates(message as addBeneiciary));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static addBeneiciary create() => addBeneiciary._();
  addBeneiciary createEmptyInstance() => create();
  static $pb.PbList<addBeneiciary> createRepeated() => $pb.PbList<addBeneiciary>();
  @$core.pragma('dart2js:noInline')
  static addBeneiciary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<addBeneiciary>(create);
  static addBeneiciary _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => clearField(1);

  @$pb.TagNumber(2)
  Beneficiaries get beneiciary => $_getN(1);
  @$pb.TagNumber(2)
  set beneiciary(Beneficiaries v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasBeneiciary() => $_has(1);
  @$pb.TagNumber(2)
  void clearBeneiciary() => clearField(2);
  @$pb.TagNumber(2)
  Beneficiaries ensureBeneiciary() => $_ensure(1);
}

