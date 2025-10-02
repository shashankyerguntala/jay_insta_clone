import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/domain/entity/user_entity.dart';
import 'package:jay_insta_clone/presentation/features/authentication/sign_in/screens/sign_in_screen.dart';
import 'package:jay_insta_clone/presentation/features/authentication/sign_up/screens/sign_up_screen.dart';
import 'package:jay_insta_clone/presentation/features/create_post/screens/create_post.dart';
import 'package:jay_insta_clone/presentation/features/home/screens/home_screen.dart';

import 'package:jay_insta_clone/presentation/features/profile/screens/profile_screen.dart';

class GoRoutes {
  final GoRouter goRoutes = GoRouter(
    initialLocation: '/home',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          final location = state.uri.toString();
          int currentIndex = 0;
          if (location.startsWith('/home')) {
            currentIndex = 0;
          } else if (location.startsWith('/create')) {
            currentIndex = 1;
          } else if (location.startsWith('/profile')) {
            currentIndex = 2;
          }
          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                switch (index) {
                  case 0:
                    context.go('/home');
                    break;
                  case 1:
                    context.go('/create');
                    break;
                  case 2:
                    context.go('/profile');
                    break;
                }
              },
              backgroundColor: ColorConstants.backgroundColor,
              selectedItemColor: ColorConstants.primaryColor,
              unselectedItemColor: ColorConstants.hintColor,
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home_outlined),
                  activeIcon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: ColorConstants.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.home, color: Colors.white),
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.add_box_outlined),
                  activeIcon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: ColorConstants.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.add_box, color: Colors.white),
                  ),
                  label: "Create",
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.person_outline),
                  activeIcon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: ColorConstants.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                  label: "Profile",
                ),
              ],
            ),
          );
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) {
              final extra = state.extra;
              final User user;

              if (extra != null && extra is User) {
                user = extra;
              } else {
                user = User(
                  username: 'shash',
                  email: 'shash@gmail.com',
                  role: 'user',
                  isModerator: false,
                );
              }
              return HomeScreen(user: user);
            },
          ),
          GoRoute(
            path: '/create',
            builder: (context, state) => const CreatePost(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(path: '/signin', builder: (context, state) => SignInScreen()),
      GoRoute(path: '/signup', builder: (context, state) => SignUpScreen()),
    ],
  );
}
