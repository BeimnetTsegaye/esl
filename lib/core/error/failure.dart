import 'package:freezed_annotation/freezed_annotation.dart';
part 'failure.freezed.dart';

@freezed
abstract class Failure with _$Failure {
  const factory Failure.serverFailure({String? message, Map<String, dynamic>? errorDetails}) = ServerFailure;
  const factory Failure.cacheFailure({String? message}) = CacheFailure;
  const factory Failure.networkFailure({String? message}) = NetworkFailure;
  const factory Failure.unexpectedFailure({String? message}) = UnexpectedFailure;
}
