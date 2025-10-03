import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/di/di.dart';

import 'package:jay_insta_clone/presentation/features/profile/bloc/profile_bloc.dart';
import 'package:jay_insta_clone/presentation/features/profile/bloc/profile_event.dart';
import 'package:jay_insta_clone/presentation/features/profile/bloc/profile_state.dart';
import 'package:jay_insta_clone/presentation/features/profile/widgets/post_tab.dart';

import 'package:jay_insta_clone/presentation/features/profile/widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  final String userId;
  const ProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<ProfileBloc>()..add(FetchApprovedPostsEvent(userId)),
      child: Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Profile",
            style: TextStyle(
              color: ColorConstants.textPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              color: ColorConstants.textPrimaryColor,
              onPressed: () {},
            ),
          ],
        ),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  String role = "user";
                  bool requested = false;

                  if (state is ProfileLoaded) {
                    //! requested = state.hasRequestedModerator;
                  }

                  return ProfileHeader(
                    userRole: role,
                    hasRequestedModerator: requested,
                    onModeratorRequest: () {
                      context.read<ProfileBloc>().add(BecomeModeratorEvent());
                    },
                    onSignOut: () {
                      context.read<ProfileBloc>().add(SignOutEvent());
                    },
                  );
                },
              ),
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: ColorConstants.backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: ColorConstants.textSecondaryColor,
                  indicator: BoxDecoration(
                    color: ColorConstants.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  padding: EdgeInsets.all(4),
                  tabs: [
                    Tab(text: "Approved"),
                    Tab(text: "Pending"),
                    Tab(text: "Declined"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    PostsTab(userId: userId, type: "approved"),
                    PostsTab(userId: userId, type: "pending"),
                    PostsTab(userId: userId, type: "declined"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
