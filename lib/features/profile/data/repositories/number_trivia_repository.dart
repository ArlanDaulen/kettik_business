import 'package:kettik_business/core/error/exceptions.dart';
import 'package:kettik_business/core/network/network_info.dart';
import 'package:kettik_business/features/profile/data/datasources/number_trivia_local_data_source.dart';
import 'package:kettik_business/features/profile/domain/entities/number_trivia.dart';
import 'package:kettik_business/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kettik_business/features/profile/domain/repositories/number_trivia_repository.dart';

import '../datasources/number_trivia_remote_data_source.dart';
import '../models/number_trivia_model.dart';

typedef _ConcreteOrRandomChooser = Future<NumberTriviaModel> Function();

class NumberTriviaRepositoryImplementation implements NumberTriviaRepository {
  final NumberTriviaLocalDataSource localDataSource;
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImplementation(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      _ConcreteOrRandomChooser getConcreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia!);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, NumberTrivia>>? getConcreteNumberTrivia(
          int number) async =>
     await _getTrivia(() => remoteDataSource.getConreteNumberTrivia(number)!);

  @override
  Future<Either<Failure, NumberTrivia>>? getRandomNumberTrivia() async =>
     await _getTrivia(() => remoteDataSource.getRandomNumberTrivia()!);
}
