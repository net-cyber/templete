import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:templete/src/app_widget.dart';
import 'package:templete/src/core/di/dependency_manager.dart';
import 'package:templete/src/core/utils/local_storage.dart';
import 'package:templete/src/presentation/theme/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() async {
  setUpDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.getInstance();
   SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );
    runApp(const ProviderScope(child: AppWidget()));
}
