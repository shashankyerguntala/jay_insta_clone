import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/presentation/features/profile/widgets/moderator_request_dialogue.dart';
import 'package:jay_insta_clone/presentation/features/profile/widgets/sign_out_dialogue.dart';

import 'role_badge.dart';

class ProfileHeader extends StatelessWidget {
  final String userRole;
  final bool hasRequestedModerator;
  final VoidCallback onModeratorRequest;
  final VoidCallback onSignOut;

  const ProfileHeader({
    super.key,
    required this.userRole,
    required this.hasRequestedModerator,
    required this.onModeratorRequest,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.primaryColor.withAlpha(8),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          RoleBadge(userRole: 'moderator'),
          const SizedBox(height: 16),
          const Text(
            "Shashank Y",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorConstants.textPrimaryColor,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "shashank@example.com",
            style: TextStyle(
              fontSize: 14,
              color: ColorConstants.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 12),
          RoleBadge(userRole: userRole, isTextBadge: true),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: hasRequestedModerator
                    ? Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.orange.withAlpha(10),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.orange.withAlpha(30),
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.hourglass_empty,
                              color: Colors.orange,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Moderator Request Pending",
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () => ModeratorRequestDialog.show(
                          context,
                          onModeratorRequest,
                        ),
                        icon: const Icon(Icons.shield_outlined, size: 20),
                        label: const Text(
                          "Become a Moderator",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorConstants.borderColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.logout_rounded),
                  color: ColorConstants.errorColor,
                  onPressed: () => SignOutDialog.show(context, onSignOut),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
