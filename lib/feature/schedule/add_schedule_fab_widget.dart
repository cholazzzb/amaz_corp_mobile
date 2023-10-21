import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddScheduleFAB extends StatelessWidget {
  const AddScheduleFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      child: const Icon(Icons.add),
      onPressed: () {
        context.goNamed('');
      },
    );
  }
}
