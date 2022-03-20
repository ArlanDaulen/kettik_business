import 'package:dartz/dartz.dart';
import 'package:kettik_business/core/error/failures.dart';
import 'package:kettik_business/features/profile/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
