import 'package:kettik_business/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kettik_business/core/usecases/usecase.dart';
import 'package:kettik_business/features/profile/domain/entities/number_trivia.dart';
import 'package:kettik_business/features/profile/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>?> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}
