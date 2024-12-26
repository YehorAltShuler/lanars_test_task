# lanars_test_task

**Lanars test task** is a mobile application developed to demonstrate Flutter development skills. It includes essential data management features, library integrations, and modern UI/UX practices.

Lanars Test Task

## Requirements

- [Lanars Test Task Mobile developer](https://docs.google.com/document/d/1nJVR4T-Naadx4K72zyliLPcX6kqMBWBPUDJEV2aDcqo/edit?tab=t.0)

## Application Description

The app provides the following features:
- **Authentication**:
  - Users can log in and log out.
  - User state is stored locally.
- **Themes**:
  - Supports light and dark themes.
  - Theme settings are stored locally.
- **List of Feeds**:
  - Browse a list of items with the following capabilities:
    - Sort items in ascending order.
    - Paginate through a large dataset.
    - Refresh the list using a pull-to-refresh gesture.
    - Perform local search within the list.
  - Tap any image in the app to view it in fullscreen mode.

## Installation and Setup

1. Ensure [Flutter SDK](https://flutter.dev/docs/get-started/install) version **3.6.0** or higher is installed.
2. Clone the repository:
   ```bash
   git clone <repository_url>
   ```
3. Navigate to the project directory:
   ```bash
   cd lanars_test_task
   ```
4. Install dependencies:
   ```bash
   flutter pub get
   ```
5. Run the application:
   ```bash
   flutter run
   ```

## Libraries Used

| Library                      | Version  | Purpose                                                                     |
|------------------------------|----------|-----------------------------------------------------------------------------|
| `auto_route`                 | ^9.2.2   | Routing management within the application.                                 |
| `cached_network_image`       | ^3.4.1   | Caching images for improved performance.                                   |
| `cupertino_icons`            | ^1.0.8   | Provides Cupertino-style icons.                                            |
| `dio`                        | ^5.7.0   | HTTP client for making network requests.                                   |
| `flutter_bloc`               | ^8.1.6   | State management using the BLoC architecture.                              |
| `get_it`                     | ^8.0.3   | Service Locator for dependency injection.                                  |
| `json_annotation`            | ^4.9.0   | Model generation for JSON data handling.                                   |
| `logger`                     | ^2.5.0   | Logging for application debugging.                                         |
| `objectbox`                  | ^4.0.3   | Local database for storing user state and data.                            |
| `objectbox_sync_flutter_libs`| ^4.0.3   | Sync support for ObjectBox.                                                |
| `photo_view`                 | ^0.15.0  | Zoom and fullscreen viewing of images.                                     |
| `retrofit`                   | ^4.4.1   | HTTP client generation based on annotations.                               |
| `shared_preferences`         | ^2.3.4   | Local storage for data such as user state and theme settings.              |

## Dev Dependencies

| Library                | Version  | Purpose                                                                     |
|------------------------|----------|-----------------------------------------------------------------------------|
| `auto_route_generator` | ^9.0.0   | Code generation for `auto_route` routing.                                  |
| `build_runner`         | ^2.4.14  | Generates helper code (e.g., JSON serialization, routing).                 |
| `flutter_lints`        | ^5.0.0   | Linting rules for code quality.                                            |
| `json_serializable`    | ^6.9.0   | Generates JSON serialization/deserialization code.                         |
| `objectbox_generator`  | ^4.0.3   | Generates code for ObjectBox models.                                       |
| `retrofit_generator`   | ^9.1.5   | Generates API clients for `retrofit`.                                      |

## Testing Environment

The application has been tested on the following platforms:
- **iOS Simulator** running iOS 16.0
- **Android Emulator** running API Level 28
