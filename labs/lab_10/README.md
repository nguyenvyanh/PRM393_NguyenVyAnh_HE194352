# Lab10_Full

Final integrated Flutter project for Lab 10: Authentication, Session
Management & Notifications.

## Features

- SplashScreen routing.
- Real REST API login with DummyJSON.
- Auto-login and logout with SharedPreferences.
- Firebase Google Sign-In.
- Local notification after successful login.

## Project Structure

```text
lib/
  main.dart
  app/
    lab10_app.dart
  core/
    constants/
      session_keys.dart
  features/
    auth/
      data/
        auth_api.dart
        firebase_google_auth_service.dart
        session_manager.dart
      domain/
        login_response.dart
      presentation/
        screens/
          login_screen.dart
          splash_screen.dart
        widgets/
          login_card.dart
    home/
      presentation/
        screens/
          home_screen.dart
        widgets/
          api_session_card.dart
          google_session_card.dart
    notifications/
      notification_service.dart
```

`main.dart` only bootstraps Firebase, notifications, and the root app. Feature
logic is split into `auth`, `home`, and `notifications` so the project is easier
to maintain.

## DummyJSON Test Account

- Username: `emilys`
- Password: `emilyspass`

## Firebase Setup For Google Sign-In

```powershell
firebase login
dart pub global activate flutterfire_cli
flutterfire configure
```

Recommended setup:

1. Create a Firebase project.
2. Add Android app with package name `com.example.lab_10`.
3. Download `google-services.json`.
4. Put it at `android/app/google-services.json`.
5. Enable Google provider in Firebase Console > Authentication > Sign-in
   method.

For Android SHA keys:

```powershell
cd android
.\gradlew signingReport
```

Add the debug SHA-1 and SHA-256 values to the Android app in Firebase Console,
then download `google-services.json` again if Firebase asks you to.

The app can still run DummyJSON login without Firebase config. Google Sign-In
requires `android/app/google-services.json`.

## Run

```powershell
flutter pub get
flutter run
```

## Verify

```powershell
flutter analyze
flutter test
```
