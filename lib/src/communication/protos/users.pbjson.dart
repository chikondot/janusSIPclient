///
//  Generated code. Do not modify.
//  source: lib/src/communication/protos/users.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const UserStatus$json = const {
  '1': 'UserStatus',
  '2': const [
    const {'1': 'SUSPENDED', '2': 0},
    const {'1': 'UNSUBSCRIBED', '2': 1},
    const {'1': 'SUBSCRIBED', '2': 2},
  ],
};

const Balance$json = const {
  '1': 'Balance',
  '2': const [
    const {'1': 'currency', '3': 1, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
  ],
};

const Beneficiaries$json = const {
  '1': 'Beneficiaries',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 9, '10': 'user'},
  ],
};

const Additional$json = const {
  '1': 'Additional',
  '2': const [
    const {'1': 'identity', '3': 1, '4': 1, '5': 9, '10': 'identity'},
    const {'1': 'nationality', '3': 2, '4': 1, '5': 9, '10': 'nationality'},
    const {'1': 'dob', '3': 3, '4': 1, '5': 9, '10': 'dob'},
    const {'1': 'gender', '3': 4, '4': 1, '5': 9, '10': 'gender'},
    const {'1': 'banking', '3': 5, '4': 1, '5': 9, '10': 'banking'},
    const {'1': 'occupation', '3': 6, '4': 1, '5': 9, '10': 'occupation'},
    const {'1': 'employer', '3': 7, '4': 1, '5': 9, '10': 'employer'},
    const {'1': 'employerAdress', '3': 8, '4': 1, '5': 9, '10': 'employerAdress'},
    const {'1': 'status', '3': 9, '4': 1, '5': 14, '6': '.users.UserStatus', '10': 'status'},
    const {'1': 'beneficiaries', '3': 10, '4': 3, '5': 11, '6': '.users.Beneficiaries', '10': 'beneficiaries'},
  ],
};

const Account$json = const {
  '1': 'Account',
  '2': const [
    const {'1': '_id', '3': 1, '4': 1, '5': 9, '10': 'Id'},
    const {'1': 'balance', '3': 2, '4': 1, '5': 1, '10': 'balance'},
    const {'1': 'modified', '3': 3, '4': 1, '5': 9, '10': 'modified'},
  ],
};

const User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'contact', '3': 2, '4': 1, '5': 9, '10': 'contact'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'address', '3': 4, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'domain', '3': 5, '4': 1, '5': 9, '10': 'domain'},
    const {'1': 'password', '3': 6, '4': 1, '5': 9, '10': 'password'},
    const {'1': 'balance', '3': 7, '4': 1, '5': 1, '10': 'balance'},
    const {'1': 'reference', '3': 8, '4': 1, '5': 3, '10': 'reference'},
    const {'1': 'additional', '3': 9, '4': 1, '5': 11, '6': '.users.Additional', '10': 'additional'},
    const {'1': 'created', '3': 997, '4': 1, '5': 9, '10': 'created'},
    const {'1': 'modified', '3': 998, '4': 1, '5': 9, '10': 'modified'},
    const {'1': 'verification', '3': 999, '4': 1, '5': 9, '10': 'verification'},
  ],
};

const verifyUser$json = const {
  '1': 'verifyUser',
  '2': const [
    const {'1': 'contact', '3': 1, '4': 1, '5': 9, '10': 'contact'},
  ],
};

const loginUser$json = const {
  '1': 'loginUser',
  '2': const [
    const {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'domain', '3': 2, '4': 1, '5': 9, '10': 'domain'},
    const {'1': 'password', '3': 3, '4': 1, '5': 9, '10': 'password'},
  ],
};

const createUser$json = const {
  '1': 'createUser',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.users.User', '10': 'user'},
  ],
};

const infoUser$json = const {
  '1': 'infoUser',
  '2': const [
    const {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'domain', '3': 2, '4': 1, '5': 9, '10': 'domain'},
  ],
};

const updateUser$json = const {
  '1': 'updateUser',
  '2': const [
    const {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'contact', '3': 2, '4': 1, '5': 9, '10': 'contact'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'address', '3': 4, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'password', '3': 5, '4': 1, '5': 9, '10': 'password'},
    const {'1': 'domain', '3': 6, '4': 1, '5': 9, '10': 'domain'},
    const {'1': 'additional', '3': 7, '4': 1, '5': 11, '6': '.users.Additional', '10': 'additional'},
  ],
};

const detailsUser$json = const {
  '1': 'detailsUser',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
    const {'1': '_id', '3': 2, '4': 1, '5': 9, '10': 'Id'},
    const {'1': 'username', '3': 3, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'contact', '3': 4, '4': 1, '5': 9, '10': 'contact'},
    const {'1': 'email', '3': 5, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'address', '3': 6, '4': 1, '5': 9, '10': 'address'},
  ],
};

const addBeneiciary$json = const {
  '1': 'addBeneiciary',
  '2': const [
    const {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'beneiciary', '3': 2, '4': 1, '5': 11, '6': '.users.Beneficiaries', '10': 'beneiciary'},
  ],
};

