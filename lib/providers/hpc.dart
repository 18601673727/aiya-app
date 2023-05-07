import 'dart:io';
import 'package:http_plus/http_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hpc.g.dart';

@riverpod
HttpPlusClient hpc(HpcRef ref) {
  final client = HttpPlusClient(
    enableHttp2: false,
    context: SecurityContext(withTrustedRoots: true),
    badCertificateCallback: (cert, host, port) => true,
    connectionTimeout: const Duration(seconds: 15),
    autoUncompress: true,
    maintainOpenConnections: true,
    maxOpenConnections: 1,
    enableLogging: true,
  );

  return client;
}
