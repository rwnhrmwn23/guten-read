# 📚 GutenRead

GutenRead is a lightweight Flutter mobile application for browsing book collections from the [Gutendex API](https://gutendex.com/). It’s designed to work both **online and offline**, with features like infinite scroll, search history, and local favorites — all while maintaining a clean architecture and testable codebase.

<img src="https://github.com/user-attachments/assets/6b1ea691-5edf-4f53-b46f-9d252d822459" width="500" alt="GutenreadApp">

---

## 🚀 Getting Started

We recommend using Flutter 3.32.5 or newer — the same version used to develop this app — to ensure full compatibility.
You can check your current version by running:
```bash
flutter --version
```

**Install dependencies & generate code**

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```
`build_runner` is used for code generation for packages like `freezed`, `json_serializable`, and `isar`.
The --delete-conflicting-outputs flag will clean up old generated files to avoid conflicts.

## 📦 Dependencies

| Package                 | Description                       | Pub.dev Link                                              |
| ----------------------- | --------------------------------- | --------------------------------------------------------- |
| flutter                 | Flutter SDK                       | [flutter.dev](https://flutter.dev)                        |
| freezed\_annotation     | Model immutability annotations    | [pub.dev](https://pub.dev/packages/freezed_annotation)    |
| flutter\_riverpod       | State management                  | [pub.dev](https://pub.dev/packages/flutter_riverpod)      |
| flutter\_hooks          | Widget lifecycle utils            | [pub.dev](https://pub.dev/packages/flutter_hooks)         |
| fluttertoast            | Show toast messages               | [pub.dev](https://pub.dev/packages/fluttertoast)          |
| dio                     | HTTP client                       | [pub.dev](https://pub.dev/packages/dio)                   |
| json\_annotation        | JSON serialization                | [pub.dev](https://pub.dev/packages/json_annotation)       |
| go\_router              | Navigation routing                | [pub.dev](https://pub.dev/packages/go_router)             |
| smooth\_page\_indicator | Carousel page indicator           | [pub.dev](https://pub.dev/packages/smooth_page_indicator) |
| cached\_network\_image  | Efficient image caching           | [pub.dev](https://pub.dev/packages/cached_network_image)  |
| intl                    | Internationalization              | [pub.dev](https://pub.dev/packages/intl)                  |
| logger                  | Logging helper                    | [pub.dev](https://pub.dev/packages/logger)                |
| path\_provider          | Access local storage dirs         | [pub.dev](https://pub.dev/packages/path_provider)         |
| connectivity\_plus      | Check network status              | [pub.dev](https://pub.dev/packages/connectivity_plus)     |
| shared\_preferences     | Persistent local storage          | [pub.dev](https://pub.dev/packages/shared_preferences)    |
| isar                    | High-performance local DB         | [isar.dev](https://isar.dev)                              |
| isar\_flutter\_libs     | Required native bindings for Isar | [isar.dev](https://isar.dev)                              |

🧪 Dev Dependencies

| Package                             | Description                   | Pub.dev Link                                                                      |
| ----------------------------------- | ----------------------------- | --------------------------------------------------------------------------------- |
| flutter\_test                       | Built-in Flutter test SDK     | [flutter.dev](https://flutter.dev)                                                |
| integration\_test                   | Flutter integration testing   | [flutter.dev](https://docs.flutter.dev/cookbook/testing/integration/introduction) |
| mocktail                            | Mocking for tests             | [pub.dev](https://pub.dev/packages/mocktail)                                      |
| freezed                             | Codegen for immutable classes | [pub.dev](https://pub.dev/packages/freezed)                                       |
| build\_runner                       | Code generation               | [pub.dev](https://pub.dev/packages/build_runner)                                  |
| flutter\_lints                      | Recommended Flutter lints     | [pub.dev](https://pub.dev/packages/flutter_lints)                                 |
| isar\_generator                     | Codegen for Isar DB           | [isar.dev](https://isar.dev)                                                      |
| json\_serializable                  | Codegen for JSON mapping      | [pub.dev](https://pub.dev/packages/json_serializable)                             |
| path\_provider\_platform\_interface | Interface for path\_provider  | [pub.dev](https://pub.dev/packages/path_provider_platform_interface)              |

## 🧱 Architecture Overview

This structure follows Domain-Driven Design principles, promoting clear separation of concerns and long-term scalability.

<img width="1122" alt="Screenshot 2025-07-02 at 16 48 35" src="https://github.com/user-attachments/assets/3a86b5c5-80da-4c2b-83d2-f7e4c93e3ad1" />

The project follows a clean architecture pattern:

- Data Layer: Handles Gutendex API (via Dio) and Isar local database
- Domain Layer: Pure models and business logic
- Presentation Layer: UI with Flutter & Riverpod for state management

I use a DataMapper to turn raw API and database models (with @freezed and @collection) into clean Book entities.
This keeps the domain layer free from any framework, making the codebase easier to test, scale, and maintain.

## ✨ Features

- 🔍 **Search** from local database first, fallback to remote API
- 🧠 **Smart Search History** saved locally with keyword suggestions
- 💾 **Offline Support** using Isar local database
- ♾️ **Infinite Scroll Pagination** for book browsing
- ❤️ **Favorites** system with persistent storage
- ✅ **Unit Tested** business logic
- 🧱 Follows **Clean Architecture** principles
- 🚀 Built using **Flutter + Riverpod + Isar**

## 📱 Screens Overview

<img src="https://github.com/user-attachments/assets/22424ac3-5443-4262-8aae-d107a2e29735" width="180" height="390" alt="GutenreadApp">
<img src="https://github.com/user-attachments/assets/187a9adf-43a0-48e8-855b-c111adc1a445" width="180" height="390" alt="GutenreadApp">
<img src="https://github.com/user-attachments/assets/7bf91e0f-0ff0-421f-85a8-89515d1c3718" width="180" height="390" alt="GutenreadApp">
<img src="https://github.com/user-attachments/assets/d8be46a6-633d-454b-8054-ef249dd0368d" width="180" height="390" alt="GutenreadApp">

### 🏠 Home Screen
- Displays popular books (from Gutendex)
- Infinite scroll support
- Tapping an item opens the detail page

### 🔍 Search Page
- Search locally first
- If not found, query remote API
- Save results into local DB (with validation)
- Save search keyword into history

### 📖 Book Detail
- Show book info (title, author, etc)
- Allows marking a book as favorite ❤️

### ❤️ Favorites Page
- Displays user-marked favorite books
- Stored and loaded from local DB
- Supports remove from favorites

## 🧠 Why This Matters

GutenRead demonstrates how Flutter apps can stay performant and scalable by:
- Using Riverpod for context-independent state management
- Applying clean architecture to keep the code maintainable
- Integrating Isar DB for blazing-fast offline support
- Supporting async state handling with `AsyncValue` and `StateNotifier`

This makes the app not only functional, but also a great base for real-world production code.

## 🧪 Testing

We use `flutter test` to ensure:
- Business logic behaves as expected
- Bugs are caught early
- Safe and confident future refactors

```bash
flutter test
```

## 🎨 Design Inspiration

Special ❤️ to

- [uiuxcreative](https://www.figma.com/design/Y4SYSnw7679XIn95egZc6C/Book-Reading-app--Community-?node-id=13-138&p=f&t=P0VCzJgMQ2mj98X9-0)
- [appuidesignkit](https://www.figma.com/design/zQ02p3fQxc12jLEtooFs8d/Book-App-UI-KIT--Community-?node-id=1-665&p=f&t=RDbD225ePtvWLurX-0)