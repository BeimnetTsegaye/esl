import 'package:esl/core/error/failure.dart';
import 'package:esl/features/home/domain/entities/hero.dart';
import 'package:fpdart/fpdart.dart';

abstract class HeroRepository {
  Future<Either<Failure, HeroEntity>> getHeroes();
}
