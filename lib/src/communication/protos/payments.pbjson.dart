///
//  Generated code. Do not modify.
//  source: lib/src/communication/protos/payments.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const PaymentStatus$json = const {
  '1': 'PaymentStatus',
  '2': const [
    const {'1': 'SUCCESS', '2': 0},
    const {'1': 'FAILED', '2': 1},
    const {'1': 'PENDING', '2': 2},
  ],
};

const PaymentMethod$json = const {
  '1': 'PaymentMethod',
  '2': const [
    const {'1': 'PAYPAL', '2': 0},
    const {'1': 'PAYNOW', '2': 1},
    const {'1': 'HOTRECHARGE', '2': 2},
    const {'1': 'STRIPE', '2': 3},
    const {'1': 'BALANCE', '2': 4},
  ],
};

const PaymentDetails$json = const {
  '1': 'PaymentDetails',
  '2': const [
    const {'1': 'transactionID', '3': 1, '4': 1, '5': 9, '10': 'transactionID'},
    const {'1': 'hash', '3': 2, '4': 1, '5': 9, '10': 'hash'},
  ],
};

const Payment$json = const {
  '1': 'Payment',
  '2': const [
    const {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'contact', '3': 2, '4': 1, '5': 9, '10': 'contact'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'domain', '3': 6, '4': 1, '5': 9, '10': 'domain'},
    const {'1': 'status', '3': 7, '4': 1, '5': 14, '6': '.payment.PaymentStatus', '10': 'status'},
    const {'1': 'method', '3': 8, '4': 1, '5': 14, '6': '.payment.PaymentMethod', '10': 'method'},
    const {'1': 'details', '3': 9, '4': 1, '5': 11, '6': '.payment.PaymentDetails', '10': 'details'},
    const {'1': 'created', '3': 999, '4': 1, '5': 9, '10': 'created'},
  ],
};

const paymentRequest$json = const {
  '1': 'paymentRequest',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.payment.Payment', '10': 'payment'},
    const {'1': 'nonce', '3': 2, '4': 1, '5': 9, '10': 'nonce'},
  ],
};

const infoPayment$json = const {
  '1': 'infoPayment',
  '2': const [
    const {'1': 'contact', '3': 1, '4': 1, '5': 9, '10': 'contact'},
  ],
};

const detailsPayment$json = const {
  '1': 'detailsPayment',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
  ],
};

