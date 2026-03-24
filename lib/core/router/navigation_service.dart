import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_eyes/core/constants/app_keys.dart';

class NavigationService {
  NavigationService._();

  static BuildContext get _context => AppKeys.rootNavigatorKey.currentContext!;

  static void go(String location, {Object? extra}) =>
      _context.go(location, extra: extra);

  static void push(String location, {Object? extra}) =>
      _context.push(location, extra: extra);

  static void pop<T>([T? result]) => _context.pop(result);

  static void pushNamed(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) => _context.pushNamed(
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  );

  static void goNamed(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) => _context.goNamed(
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  );

  static void replace(String location, {Object? extra}) =>
      _context.replace(location, extra: extra);
}
