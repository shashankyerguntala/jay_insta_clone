import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback approve;
  final VoidCallback reject;

  const ActionButtons({
    super.key,
    required this.approve,
    required this.reject,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
          onPressed: reject,
          icon: const Icon(Icons.close, size: 18),
          label: const Text('Decline'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: approve,
          icon: const Icon(Icons.check, size: 18),
          label: const Text('Approve'),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstants.primaryColor,
            foregroundColor: ColorConstants.backgroundColor,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
