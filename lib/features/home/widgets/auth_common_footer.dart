import 'package:flutter/material.dart';

class CommonFooterLinks extends StatelessWidget {
  const CommonFooterLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(
              context,
            ).colorScheme.onSecondary.withAlpha(75),
          ),
          child: const Text("Conditions of Use"),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(
              context,
            ).colorScheme.onSecondary.withAlpha(75),
          ),
          child: const Text("Privacy Notice"),
        ),
      ],
    );
  }
}
