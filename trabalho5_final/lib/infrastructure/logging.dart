import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

class _LoggerImpl implements Logger {
  final String _className;

  _LoggerImpl(this._className);

  void _log(
    String message, {
    required DiagnosticLevel level,
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: _className,
      error: error,
      stackTrace: stackTrace,
      level: level.index,
      time: DateTime.now(),
      zone: Zone.current,
    );
  }

  @override
  void debug(String message) {
    _log(message, level: DiagnosticLevel.debug);
  }

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    _log(message,
        level: DiagnosticLevel.error, error: error, stackTrace: stackTrace);
  }

  @override
  void info(String message) {
    _log(message, level: DiagnosticLevel.info);
  }

  @override
  void warning(String message) {
    _log(message, level: DiagnosticLevel.warning);
  }
}

abstract class LoggerFactory {
  static Logger getLogger(String className) => _LoggerImpl(className);
  static Logger getLoggerFromClass(Object clazz) =>
      _LoggerImpl((clazz).toString());
}

abstract class Logger {
  void info(String message);

  void error(String message, {Object? error, StackTrace? stackTrace});

  void warning(String message);

  void debug(String message);
}
