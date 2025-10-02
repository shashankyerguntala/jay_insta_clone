import 'package:get_it/get_it.dart';
import 'package:jay_insta_clone/core%20/network/dio_client.dart';
import 'package:jay_insta_clone/data%20/remote_data_sources/auth_data_source.dart';
import 'package:jay_insta_clone/data%20/remote_data_sources/post_data_source.dart';
import 'package:jay_insta_clone/data%20/repository_impl/auth_repo_impl.dart';
import 'package:jay_insta_clone/data%20/repository_impl/post_repo_impl.dart';
import 'package:jay_insta_clone/domain/repository/auth_repo.dart';
import 'package:jay_insta_clone/domain/repository/post_repository.dart';
import 'package:jay_insta_clone/domain/usecase/auth_usecase.dart';
import 'package:jay_insta_clone/domain/usecase/post_usecase.dart';
import 'package:jay_insta_clone/presentation/features/authentication/sign_in/bloc/sign_in_bloc.dart';
import 'package:jay_insta_clone/presentation/features/authentication/sign_up/bloc/sign_up_bloc.dart';
import 'package:jay_insta_clone/presentation/features/home/bloc/home_bloc.dart';

GetIt di = GetIt.instance;

class Di {
  Future<void> init() async {
    di.registerLazySingleton(() => DioClient());
    di.registerLazySingleton(() => AuthRemoteDataSource(dioClient: di()));
    di.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: di()),
    );
    di.registerLazySingleton(() => AuthUsecase(repository: di()));
    di.registerFactory(() => SignInBloc(authUsecase: di()));
    di.registerFactory(() => SignUpBloc(authUsecase: di()));

    di.registerLazySingleton<PostDataSource>(() => PostDataSource(di()));

    di.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(di()));

    di.registerLazySingleton<PostUseCase>(() => PostUseCase(di()));

    di.registerFactory<HomeBloc>(() => HomeBloc(postUseCase: di()));
  }
}
