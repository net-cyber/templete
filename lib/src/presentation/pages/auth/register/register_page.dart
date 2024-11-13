import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:templete/src/core/router/route_name.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body:  Center(
        child: TextButton(onPressed: () {
          context.goNamed(RouteName.login);
        }, child: const Text('got to login')),
      ),
    );
  }
}
