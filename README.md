
# Getting Started Guide for "temp" Flutter Project

## Introduction

Welcome to the "temp" Flutter project. This guide will walk you through the steps necessary to set up and run the project on your local development environment. 

## Prerequisites

Before you begin, ensure you have met the following requirements:

- **Flutter SDK**: Make sure you have Flutter installed on your machine. You can download it from [Flutter's official website](https://flutter.dev/docs/get-started/install).
- **Dart SDK**: The Dart SDK is included with Flutter; ensure it's properly set up.
- **IDE**: You can use any IDE that supports Flutter, such as Android Studio, IntelliJ IDEA, or Visual Studio Code.
- **Platform-specific requirements**: Depending on your target platform (iOS, Android, Web, etc.), ensure you have the necessary tools and emulators installed.

## Installation

1. **Clone the Repository**: Start by cloning the project repository to your local machine.

   ```bash
   git clone <repository-url>
   ```

2. **Navigate to the Project Directory**: Change your working directory to the project folder.

   ```bash
   cd temp
   ```

3. **Install Dependencies**: Run the following command to install the required dependencies.

   ```bash
   flutter pub get
   ```

## Running the Project

1. **Select a Target Device**: Ensure you have a target device selected. You can use an emulator or a physical device.

2. **Run the Application**: Use the following command to run the application.

   ```bash
   flutter run
   ```

   This command will build and deploy the application to the selected device.

## Project Structure

- **lib/src/app_widget.dart**: The main entry point of the application, where the `AppWidget` class is defined.
- **lib/main.dart**: Contains the `main()` function, which initializes the application and sets up dependencies.
- **lib/src/presentation/pages**: Contains the UI pages of the application, such as `OnboardingPage` and `SplashPage`.

## Configuration

- **pubspec.yaml**: This file contains the project's metadata and dependencies. Ensure all dependencies are up-to-date.

## Additional Resources

For more information on Flutter development, refer to the following resources:

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)



### architecture Overview

1. **Main Entry Point**:
   - `lib/main.dart`: This file serves as the entry point of the application. It initializes dependencies, sets up the system UI overlay style, and runs the app using `ProviderScope` and `AppWidget`.
   - Relevant lines:
     
```10:22:lib/main.dart
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
```


2. **App Widget**:
   - `lib/src/app_widget.dart`: This file defines the `AppWidget` class, which is a `ConsumerWidget` using Riverpod for state management. It sets up the `MaterialApp.router` with theming and routing configurations.
   - Relevant lines:
     
```9:37:lib/src/app_widget.dart
class AppWidget extends ConsumerWidget {
  const AppWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        themeMode: ref.watch(appProvider).isDarkMode ? ThemeMode.dark : ThemeMode.light,
        darkTheme: ThemeData.dark().copyWith(
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CustomTransitionBuilder(),
                },
              ),
            ),
        theme: ThemeData.light().copyWith(
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CustomTransitionBuilder(),
                },
              ),
        ),
      ),
    );
  }
}
```


3. **Routing**:
   - `lib/src/core/router/router.dart`: This file imports various pages and sets up the routing configuration using `go_router`.
   - Relevant lines:
     
```1:9:lib/src/core/router/router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:temp/src/core/router/route_name.dart';
import 'package:temp/src/presentation/pages/auth/login/login_page.dart';
import 'package:temp/src/presentation/pages/auth/register/register_page.dart';
import 'package:temp/src/presentation/pages/initial/no_connection/no_connection_page.dart';
import 'package:temp/src/presentation/pages/initial/onboarding/onboarding_page.dart';
import 'package:temp/src/presentation/pages/initial/splash/splash_page.dart';
import 'package:temp/src/presentation/pages/main/main_page.dart';
```


4. **Dependency Injection**:
   - `lib/src/core/di/dependency_manager.dart`: This file uses `GetIt` for dependency injection, registering services like `HttpService` and `AuthRepository`.
   - Relevant lines:
     
```1:15:lib/src/core/di/dependency_manager.dart
import 'package:get_it/get_it.dart';

import 'package:temp/src/core/handlers/http_service.dart';
import 'package:temp/src/repository/auth_repository.dart';
import 'package:temp/src/repository/impl/auth_repository_impl.dart';
final GetIt getIt = GetIt.instance;

void setUpDependencies() {
  getIt.registerLazySingleton<HttpService>(() => HttpService());
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
}

final httpService = getIt.get<HttpService>();
final authRepository = getIt.get<AuthRepository>();

```


5. **Presentation Layer**:
   - Various pages and components are defined under `lib/src/presentation/pages` and `lib/src/presentation/components`. These include:
     - `auth/login/login_page.dart`: Defines the login page.
     - `auth/register/register_page.dart`: Defines the register page.
     - `initial/no_connection/no_connection_page.dart`: Handles the no connection scenario.
     - `main/main_page.dart`: Represents the main page of the app.
     - Components like `forgot_text_button.dart` and `custom_progress_indicator.dart` are used for UI elements.

6. **State Management**:
   - Riverpod is used for state management, as seen in files like `lib/src/presentation/pages/auth/login/riverpod/provider/login_provider.dart`.

7. **Repository Layer**:
   - `lib/src/repository/auth_repository.dart` and its implementation `lib/src/repository/impl/auth_repository_impl.dart` handle authentication-related data operations.

This structure follows a typical Flutter architecture with a clear separation of concerns, using Riverpod for state management and GetIt for dependency injection.

## Folder Structure
```
lib/
│
├── main.dart
│
├── src/
│   ├── app_widget.dart
│   │
│   ├── core/
│   │   ├── di/
│   │   │   └── dependency_manager.dart
│   │   │
│   │   ├── handlers/
│   │   │   ├── api_result.dart
│   │   │   ├── http_service.dart
│   │   │   └── token_interceptor.dart
│   │   │
│   │   ├── router/
│   │   │   ├── router.dart
│   │   │   ├── route_name.dart
│   │   │   └── slide_transition.dart
│   │   │
│   │   └── utils/
│   │       ├── local_storage.dart
│   │       ├── local_storage_key.dart
│   │       └── utils.dart
│   │
│   ├── model/
│   │   ├── data/
│   │   │   ├── login_data.dart
│   │   │   └── user_data.dart
│   │   │
│   │   ├── response/
│   │   │   ├── login_response.dart
│   │   │   └── user_response.dart
│   │   │
│   │   └── models.dart
│   │
│   ├── presentation/
│   │   ├── components/
│   │   │   ├── buttons/
│   │   │   │   └── forgot_text_button.dart
│   │   │   │
│   │   │   ├── custom_progress_indicator.dart
│   │   │   └── text_fields/
│   │   │       └── outline_bordered_text_field.dart
│   │   │
│   │   ├── pages/
│   │   │   ├── auth/
│   │   │   │   ├── login/
│   │   │   │   │   ├── login_page.dart
│   │   │   │   │   └── riverpod/
│   │   │   │   │       ├── provider/
│   │   │   │   │       │   └── login_provider.dart
│   │   │   │   │       ├── state/
│   │   │   │   │       │   ├── login_state.dart
│   │   │   │   │       │   └── login_state.freezed.dart
│   │   │   │   │       └── notifier/
│   │   │   │   │           └── login_notifier.dart
│   │   │   │   └── register/
│   │   │   │       └── register_page.dart
│   │   │   │
│   │   │   ├── initial/
│   │   │   │   ├── no_connection/
│   │   │   │   │   └── no_connection_page.dart
│   │   │   │   ├── onboarding/
│   │   │   │   │   └── onboarding_page.dart
│   │   │   │   └── splash/
│   │   │   │       ├── splash_page.dart
│   │   │   │       └── riverpod/
│   │   │   │           ├── provider/
│   │   │   │           │   └── splash_provider.dart
│   │   │   │           ├── state/
│   │   │   │           │   ├── splash_state.dart
│   │   │   │           │   └── splash_state.freezed.dart
│   │   │   │           └── notifier/
│   │   │   │               └── splash_notifier.dart
│   │   │   │
│   │   │   └── main/
│   │   │       └── main_page.dart
│   │   │
│   │   └── theme/
│   │       └── app_colors.dart
│   │
│   ├── repository/
│   │   ├── auth_repository.dart
│   │   └── impl/
│   │       └── auth_repository_impl.dart
│   │
│   └── riverpod/
│       ├── notifier/
│       │   └── app_notifier.dart
│       └── state/
│           ├── app_state.dart
│           └── app_state.freezed.dart
```

### Key Components:

- **Main Entry Point**: `main.dart` initializes the app and sets up dependencies.
- **App Widget**: `app_widget.dart` is the root widget of the app, configuring themes and routing.
- **Core**: Contains essential utilities, dependency injection setup, and routing logic.
- **Model**: Defines data structures and response models.
- **Presentation**: Contains UI components and pages, organized by feature.
- **Repository**: Handles data operations, with an interface and its implementation.
- **Riverpod**: Manages state using Riverpod, with separate directories for notifiers and states.
- **Theme**: Contains theme-related configurations like colors.

This structure follows a clean architecture approach, separating concerns into distinct layers and directories.
