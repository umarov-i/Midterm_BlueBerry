# BlueBerry · NewUU Campus Updates

Flutter app for the Mobile Programming midterm, Team BlueBerry.

## Run it

Everyone uses Flutter 3.50 stable or newer (`flutter upgrade`), because the project imports Material from `package:material_ui`.

```
flutter pub get
flutter run
```

Check before every PR:

```
flutter analyze
flutter test
```

## How we work

- One branch per screen: `feature/<your-screen>`, PR into `main`. Mardon merges.
- Pull `main` before you start each day.
- Edit only the files you own. The owner is written at the top of each file.
- Navigate with the names in `AppRoutes` (`lib/app.dart`).
- Take colors from `lib/theme/app_theme.dart`, not hardcoded values.

The proposal, slides and Figma export are in `Midterm_BlueBerry/`.
