
import 'package:bts_technologie/core/network/error_message_model.dart';

class ServerException implements Exception {
  final ErrorMessageModel errorMessageModel;

  const ServerException({required this.errorMessageModel});
}

class LocalDatabaseException implements Exception {
  final ErrorMessageModel errorMessageModel;

  const LocalDatabaseException({required this.errorMessageModel});
}

// class ServerException implements Exception {}

