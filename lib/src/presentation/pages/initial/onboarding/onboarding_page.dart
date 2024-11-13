import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:templete/src/core/utils/local_storage.dart';
import 'package:templete/src/core/router/route_name.dart';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Onboarding'),
      ),
      body:  Center(
        child: TextButton(onPressed: () async {
          context.goNamed(RouteName.login);
          // save on the localstorage
          await LocalStorage.instance.setIsDoneOnboarding(true);
        }, child: const Text('Next')),
      ),
    );
  }
}
