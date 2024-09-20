import 'dart:io';

const ACCESS_TOKEN_KEY = 'ACCESS TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH TOKEN';

// Android Emulator의 localhost
const emulatorIp = '10.0.2.2';
// iOS Simulator의 localhost
const simulatorIp = '127.0.0.1';

final ip = Platform.isIOS ? simulatorIp : emulatorIp;
