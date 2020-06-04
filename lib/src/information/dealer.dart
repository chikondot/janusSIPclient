// define information for dealer onboarding here
import 'package:flutter/material.dart';

class Dealer {
  // basic dealer information
  static String get name => "janus flutter-sip client";
  static String get domain => "talk.ai.co.zw";

  // dealer color schema
  static Color get mainColor => Color(0xff6b406b);
  static Color get secColor => Colors.yellow[100];
  static Color get swatchColor => Color(0xffffcc00);

  // dealer images
  static String get logo => "images/imaswerasei_icon.png";
  static String get splash => "images/maswerasei_logo.png";

  /* 
  * NOTE : all payment intergrations and keys are handled server side and need to be added statically
  * DEALERACC : momari/payments/service
  * PAYPAL : momari/payments/service/paypal
  * STRIPE : momari/payments/service/stripe
  */
}
