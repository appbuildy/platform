# flutter_app

# Развернуть проект

1. Клонируем репо.
2. Скачиваем флаттер.
3. ```flutter channel beta```
4. ```flutter config --enable-web```
5. ```flutter run -d chrome``` или в AndroidStudio выбираем хро и ранним

ВАЖНО! Убедиться что версия flutter SDK = 1.22.1 
```flutter --version```

# Обновить тайпинги mobx
Из-за бага c тайпингами нужно откатиться на стабильный ченел, сбилдить тайпинги и вернуться

1. ```flutter channel stable```
2. ```flutter pub get```
3. ```flutter packages pub run build_runner build```
4. ```flutter channel beta```
5. ```flutter config --enable-web



## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
