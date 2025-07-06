import 'package:esl/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'usecase.freezed.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

@freezed
class NoParams with _$NoParams {}
