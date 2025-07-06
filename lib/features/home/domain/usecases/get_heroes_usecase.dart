import 'package:esl/core/error/failure.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/home/domain/entities/hero.dart';
import 'package:esl/features/home/domain/repositories/hero_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetHeroesUsecase extends UseCase<HeroEntity, NoParams> {
  final HeroRepository heroRepository;

  GetHeroesUsecase(this.heroRepository);

  @override
  Future<Either<Failure, HeroEntity>> call(NoParams params) async {
    return await heroRepository.getHeroes();
  }
}
