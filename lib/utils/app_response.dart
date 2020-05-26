import 'package:equatable/equatable.dart';

class AppResponse extends Equatable {
  final int code;
  final dynamic body;
  AppResponse({
    this.code,
    this.body,
  });

  @override
  List<Object> get props => [
        code,
        body,
      ];
  @override
  String toString() => 'AppResponse values: $props';
}
