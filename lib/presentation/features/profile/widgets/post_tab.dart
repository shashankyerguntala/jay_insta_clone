import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/presentation/features/profile/bloc/profile_bloc.dart';
import 'package:jay_insta_clone/presentation/features/profile/bloc/profile_state.dart';
import 'package:jay_insta_clone/presentation/features/profile/widgets/posts_grid.dart';

class PostsTab extends StatelessWidget {
  final String userId;
  final String type;
  const PostsTab({super.key, required this.userId, required this.type, required List<PostEntity> posts});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileLoaded) {
          return PostsGrid(
            status: 'pending',
          ); //! when the data comes pass the postEntity here
        } else if (state is ProfileError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}
