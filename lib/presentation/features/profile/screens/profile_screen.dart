import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/string_constants.dart';
import 'package:jay_insta_clone/core%20/di/di.dart';
import 'package:jay_insta_clone/core%20/helper_functions.dart';
import 'package:jay_insta_clone/data%20/data_sources/local_data_sources/auth_local_storage.dart';
import 'package:jay_insta_clone/domain/entity/user_roles.dart';
import 'package:jay_insta_clone/presentation/features/profile/bloc/profile_bloc.dart';
import 'package:jay_insta_clone/presentation/features/profile/bloc/profile_event.dart';
import 'package:jay_insta_clone/presentation/features/profile/bloc/profile_state.dart';
import 'package:jay_insta_clone/presentation/features/profile/widgets/post_tab.dart';
import 'package:jay_insta_clone/presentation/features/profile/widgets/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileBloc profileBloc;

  @override
  void initState() {
    super.initState();
    profileBloc = di<ProfileBloc>();
    AuthLocalStorage.getUid().then((uid) {
      if (uid != null) {
        profileBloc.add(FetchUserDetailsEvent(userId: uid));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: profileBloc,
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is DeleteSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(StringConstants.postDeleted)),
            );
          } else if (state is ProfileSignedOut) {
            AuthLocalStorage.clearToken();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Signed Out Successful')),
            );
            context.go('/signin');
          } else if (state is ProfileModeratorSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Moderator request sent!")),
            );
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading || state is ProfileInitial) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is ProfileLoaded ||
              state is ProfileModeratorSuccess) {
            final loadedState = state as ProfileLoaded;
            final user = loadedState.user;
            final isModerator = loadedState.isModeratorRequest;

            return Scaffold(
              backgroundColor: ColorConstants.backgroundColor,
              appBar: AppBar(
                backgroundColor: ColorConstants.fillColor,
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
                    ProfileHeader(
                      user: user,
                      hasRequestedModerator: isModerator,
                      onModeratorRequest: () {
                        final role = UserRoleExtension.fromString(user.role);

                        switch (role) {
                          case UserRole.author:
                            context.read<ProfileBloc>().add(
                              BecomeModeratorEvent(),
                            );
                            break;
                          case UserRole.moderator:
                            context.push(StringConstants.moderator);
                            break;
                          case UserRole.admin:
                            context.push(StringConstants.admin);
                            break;
                          case UserRole.superAdmin:
                            context.push(StringConstants.superAdmin);
                            break;
                        }
                      },

                      onSignOut: () {
                        context.read<ProfileBloc>().add(SignOutEvent());
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
                      child: TabBar(
                        labelColor: Colors.white,
                        unselectedLabelColor: ColorConstants.textSecondaryColor,
                        indicator: BoxDecoration(
                          color: HelperFunctions.getRoleColor(user.role),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        padding: const EdgeInsets.all(4),
                        tabs: const [
                          Tab(text: "Approved"),
                          Tab(text: "Pending"),
                          Tab(text: "Declined"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          PostsTab(posts: loadedState.approvedPosts),
                          PostsTab(posts: loadedState.pendingPosts),
                          PostsTab(posts: loadedState.declinedPosts),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ProfileError) {
            return Scaffold(body: Center(child: Text(state.message)));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
