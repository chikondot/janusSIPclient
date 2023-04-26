# Janus SIP Client

A websocket client in flutter making use of [Janus](https://github.com/meetecho/janus-gateway) [SIP plugin](https://janus.conf.meetecho.com/docs/sip.html)

## Overview of Project
- UI/UX built in pure Dart 
- Networking/Signalling using SIP over Websockets
- Audio handled by ([flutter-webrtc](https://github.com/cloudwebrtc/flutter-webrtc))
- Tested with OpenSIPS, Freeswitch.
- Should also work with Kamalio and Asterisk (TODO)

## Project Configuration
- Change all instances of the following to: 
     - Connection to Janus Server Gateway is handled in the following file: [janus.dart](https://github.com/chikondot/janusSIPclient/blob/master/lib/src/communication/janus.dart)
    ```
    _channel = new IOWebSocketChannel.connect('ws://localhost:8188', protocols: ['janus-protocol']);
    ```
     - Change `localhost` value to `{{ janus_server }}` IP

## Setup and Installation
Ensure that you have flutter and emulator/simulator installed to test

Verify everything is flutter installation is available and configured
```
$ flutter doctor
```
Clone the project onto machine
```
$ git clone https://github.com/chikondot/janusSIPclient.git
```
```
$ cd maswerasei
```
Build/Run the project
```
flutter clean
flutter pub get
flutter run
```

[ TODO: Complete this section ]
- application should have opened within emulator/device
- please note to allow permissions for calling and audio
- presented with screen below:

![Image of Homepage](https://github.com/chikondot/janusSIPclient/blob/master/images/homepage.png)

- User input on Registration :
  - SIP Registrar (eg: sip:host:port)
  - SIP Identity  (eg: sip:username@janus.example.com)
  - Username: account information of SIP register server
  - Secret: password for authentication

## Getting up a and running on iOS

Ensure terminal locale is set to `en_US.UTF-8`

## Getting up a and running on Android

[WIP]

## Supported Platform and Tested Feature
| Feature  | Android | iOS | 
|:--------:|:-------:|:---:|
|  Audio   |    X    |  X  |
|  Video   |    X    |  X  |
| Transfer |    X    |  X  |
|   DTMF   |    X    |  X  |




## License
JanusSIPClient is released under the [MIT license](https://github.com/chikondot/janusSIPclient/blob/master/LICENSE).
