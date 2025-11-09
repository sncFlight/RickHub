# RickHub 🛸

Rick and Morty character explorer app built with Flutter and BLoC pattern.

## 📱 Features

- **Character List**: Browse all Rick and Morty characters with pagination
- **Search**: Find characters by name in real-time
- **Favorites**: Save your favorite characters locally with Hive
- **Sorting**: Sort favorites by name or status
- **Dark Theme**: Toggle between light and dark themes
- **Offline Storage**: All favorites persisted locally

## 🛠 Tech Stack

- **Flutter** 3.0+
- **Dart** 3.0+
- **State Management**: BLoC
- **Local Storage**: Hive
- **API**: [Rick and Morty API](https://rickandmortyapi.com/)
- **HTTP Client**: Dio
- **Fonts**: Google Fonts

## 📋 Requirements

- Flutter SDK: \`>=3.0.0 <4.0.0\`
- Dart SDK: \`>=3.0.0 <4.0.0\`

## 🚀 Getting Started

### 1. Clone the repository

git clone https://github.com/sncFlight/RickHub.git\
cd RickHub

### 2. Install dependencies

flutter pub get

### 3. Generate required files

dart run build_runner build --delete-conflicting-outputs\
flutter pub run spider build

### 4. Run the app

flutter run

## 📦 Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| flutter_bloc | ^8.1.3 | State management |
| bloc | ^8.1.2 | Core BLoC library |
| hive | ^2.2.3 | NoSQL local database |
| hive_flutter | ^1.1.0 | Hive Flutter integration |
| dio | ^5.3.3 | HTTP client for API calls |
| google_fonts | ^6.1.0 | Custom fonts |

**Wubba Lubba Dub Dub!**
