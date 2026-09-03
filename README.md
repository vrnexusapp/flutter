# Flutter Base

A professional, production-ready Flutter codebase demonstrating best practices, clean architecture, and modern UI implementation. This repository serves as a portfolio of reusable Flutter components and architecture patterns.

## Features Included

- **Feature-First Clean Architecture**: Separation of concerns across data, domain, and presentation layers.
- **State Management**: Robust state handling using `Riverpod`.
- **Navigation**: Deep linking and declarative routing using `GoRouter`.
- **Network Layer**: Type-safe REST API integration using `Dio`.
- **Data Models**: Immutable data classes generated with `Freezed` and `json_serializable`.
- **Responsive Layouts**: Adaptive dashboards for Mobile, Tablet, and Desktop using `LayoutBuilder`.
- **Local Storage**: Persistent theme and favourites storage using `SharedPreferences`.
- **Animations**: Hero transitions, `AnimatedContainer`, and `AnimatedSwitcher` examples.
- **Forms**: Custom form fields, validation, and layout management.
- **Dialogs & Bottom Sheets**: Standardized modal presentations.

## Project Structure

```
lib/
├── app/                  # App initialization, routing, and theme definitions
├── core/                 # Shared utilities, constants, and local storage
└── features/             # Feature-first modules
    ├── animations/
    ├── dashboard/
    ├── dialogs/
    ├── favourites/
    ├── forms/
    ├── media/
    ├── products/
    └── showcase/
```

## Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/vrnexusapp/flutter.git
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Run Code Generation:**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
4. **Run the app:**
   ```bash
   flutter run
   ```

## Contributing

Please see `CONTRIBUTING.md` for details on our code of conduct, and the process for submitting pull requests to us.

## License

Copyright (c) 2026 VRNexus Technologies

This project is licensed under the MIT License - see the `LICENSE` file for details.

---
*Created by VRNexus Technologies*
*Contact: info@vrnexusapp.com*
