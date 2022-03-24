import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kettik_business/core/network/network_info.dart';
import 'package:kettik_business/core/util/input_converter.dart';
import 'package:kettik_business/features/profile/data/datasources/number_trivia_local_data_source.dart';
import 'package:kettik_business/features/profile/data/datasources/number_trivia_remote_data_source.dart';
import 'package:kettik_business/features/profile/data/repositories/number_trivia_repository.dart';
import 'package:kettik_business/features/profile/domain/repositories/number_trivia_repository.dart';
import 'package:kettik_business/features/profile/domain/usecases/get_concrete_number_trivia.dart';
import 'package:kettik_business/features/profile/domain/usecases/get_random_number_trivia.dart';
import 'package:kettik_business/features/profile/presentation/bloc/number_trivia_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// service locator
final sl = GetIt.instance;

Future<void> init() async {
  //! Features - NumberTrivia
  sl.registerFactory(() => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
      inputConverter: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Respository
  sl.registerLazySingleton<NumberTriviaRepository>(() =>
      NumberTriviaRepositoryImplementation(
          localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImplementation(client: sl()));
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImplemetation(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplementation(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
