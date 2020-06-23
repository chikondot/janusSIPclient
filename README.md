# Maswerasei

A websocket client in flutter making use of [Janus](https://github.com/meetecho/janus-gateway) [SIP plugin](https://janus.conf.meetecho.com/docs/sip.html)

## Overview of Project
- use of [flutter]() to build basic dialpad and registration page
- SIP over Websockets for signalling
- Audio handled by ([flutter-webrtc](https://github.com/cloudwebrtc/flutter-webrtc))
- Tested with OpenSIPS, Freeswitch.
- Should also work with Kamalio and Asterisk (TODO)

## Project Configuration
- change all instances of the following to 
    1. connect to janus gateway ([janus.dart](https://github.com/chikondot/maswerasei/blob/master/lib/src/communication/janus.dart))
    ```
    _channel = new IOWebSocketChannel.connect('ws://localhost:8188', protocols: ['janus-protocol']);
    ```

## Setup and Installation
- ensure that you have flutter installed and and emulator to test
- verfiy everything is ok
```
flutter doctor
```
- get project
```
git clone https://github.com/chikondot/maswerasei.git
cd maswerasei
```
- build/run project
```
flutter clean
flutter pub get
flutter run
```
- application should have opened within emulator/device
- please note to allow permissions for calling and audio
- presented with sceen below:

![Image of Homepage](https://github.com/chikondot/maswerasei/blob/master/images/homepage.png)

- input :
    username : account information of SIP register server
    domain: proxy server ip/domain
    password: password for authentication (HA1 currently implemented)

## Supported and Tested Platform
- [X] iOS && Android (Mobile)
- [ ] Chrome, macOS, Firefox (Web)

## License
maswerasei is released under the [MIT license](https://github.com/chikondot/maswerasei/blob/master/LICENSE).
