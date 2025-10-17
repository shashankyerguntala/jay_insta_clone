import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/theme_constants.dart';
import 'package:jay_insta_clone/core%20/di/di.dart';
import 'package:jay_insta_clone/core%20/helper_functions.dart';
import 'package:jay_insta_clone/presentation/features/moderator/bloc/moderator_bloc.dart';
import 'package:jay_insta_clone/presentation/features/moderator/bloc/moderator_event.dart';
import 'package:jay_insta_clone/presentation/features/moderator/bloc/moderator_state.dart';

import 'package:jay_insta_clone/presentation/features/moderator/widgets/moderator_tab_bar_View.dart';

class ModeratorScreen extends StatelessWidget {
  const ModeratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<ModeratorBloc>()..add(FetchAll()),
      child: const _ModeratorScreenBody(),
    );
  }
}

class _ModeratorScreenBody extends StatelessWidget {
  const _ModeratorScreenBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ModeratorBloc, ModeratorState>(
      listener: (context, state) {
        if (state is PostActionSuccess) {
          HelperFunctions.showSnackBar(
            context,
            'Post ${state.action} successfully!',
          );
        } else if (state is CommentActionSuccess) {
          HelperFunctions.showSnackBar(
            context,
            'Comment ${state.action} successfully!',
          );
        }
      },
      builder: (context, state) {
        if (state is ModeratorLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is ModeratorError) {
          return const _ModeratorErrorScreen();
        } else if (state is ModeratorLoaded) {
          return ModeratorTabView(posts: state.posts, comments: state.comments);
        }
        return const SizedBox();
      },
    );
  }
}

class _ModeratorErrorScreen extends StatelessWidget {
  const _ModeratorErrorScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => context.go('/moderator'),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: ColorConstants.textSecondaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              "You can't review your own post/comment !",
              style: ThemeConstants.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
