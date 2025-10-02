import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/data%20/models/post_model.dart';
import 'package:jay_insta_clone/domain/usecase/post_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

final list = [
  PostModel(
    id: 1,
    title: "Flutter UI is awesome",
    content: "Building custom widgets is easier than you think.",
    author: "john_doe",
    createdAt: DateTime.now().subtract(const Duration(minutes: 5)), status: '',
  ),
  PostModel(
    id: 2,
    title: "Dark mode or light mode?",
    content: "I prefer dark mode for coding. What about you?",
    author: "jane_doe",
    createdAt: DateTime.now().subtract(const Duration(hours: 1)), status: '',
  ),
  PostModel(
    id: 3,
    title: "Animations in Flutter",
    content: "Using AnimatedBuilder and Lottie makes apps feel alive!",
    author: "flutter_dev",
    createdAt: DateTime.now().subtract(const Duration(hours: 3)), status: '',
  ),
];

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PostUseCase postUseCase;

  HomeBloc({required this.postUseCase}) : super(HomeInitial()) {
    on<FetchPostsEvent>(onFetchPosts);
  }

  Future<void> onFetchPosts(
    FetchPostsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    Future.delayed(Duration(seconds: 1));
    emit(HomeLoaded(list));

    // final result = await postUseCase.getAllPosts();

    // result.fold(
    //   (failure) => emit(HomeError(failure.message)),
    //   (posts) => emit(HomeLoaded(posts)),
    // );
  }
}
