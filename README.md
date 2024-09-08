# Threads Clone App

This is a learning project that replicates the core functionality of the Threads app, using **SwiftUI** for the frontend and **Firebase** for the backend. The goal is to build a scalable app architecture, practice best practices in app development, and explore modern iOS development techniques.

## Features

- **User Authentication**
  - **LoginView**: Users can log in using their email and password.
  - **RegistrationView**: New users can sign up with email, password, and other required details.

- **Root Tab Bar**
  - A tab bar with five primary views:
    - **FeedView**: Displays user posts and threads.
    - **ExploreView**: Explore new content and search for threads.
    - **CreateThreadsView**: Allows users to create new threads.
    - **ActivityView**: Shows user notifications and interactions.
    - **ProfileView**: Displays user profile and settings.
  - **Dynamic System Icon Variants**: The system icons in the tab bar dynamically adjust based on the selected tab using:
    
    ```swift
    .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
    ```

    This changes the appearance of icons (e.g., filled when selected).

- **FeedView**
  - Shows all threads using a `ScrollView`, `LazyVStack`, and a subview called `ThreadCellView`.
  - **Styling**: The `FeedView` has been designed to include a smooth scrolling experience with a well-organized list of threads.

- **ExploreView**
  - Provides an interface to explore new content and search for threads.
  - **Styling**: The `ExploreView` features a clean and intuitive layout to facilitate easy navigation and content discovery.

- **ProfileView**
  - Displays user profile information and settings.
  - **Matched Geometry Effect**: Implemented to animate transitions between different profile sections.
    
    ```swift
    .matchedGeometryEffect(id: "sharedID", in: animation)
    ```

    This technique is used to create smooth, visually appealing animations for UI transitions.

- **Architecture**
  - The project is structured into several folders to maintain organization and separation of concerns:
    - **App**: Contains app configuration files and the main entry point.
    - **Core**: Core functionalities and shared logic across the app.
    - **Extensions**: Extensions to system classes for enhanced functionality.
    - **Model**: Data models and objects.
    - **Services**: Services for interacting with Firebase (e.g., authentication, database operations).
    - **Utils**: Utility functions and helpers.

- **Custom View Modifiers**
  - Custom SwiftUI view modifiers have been implemented to promote reusable and maintainable code.

## Technology Stack

- **Frontend**: SwiftUI
- **Backend**: Firebase
  - Authentication
  - Firestore (to be implemented)
  - Firebase Storage (to be implemented)

## Installation

1. Clone the repository.
2. Run `pod install` to install dependencies.
3. Open the `.xcworkspace` file in Xcode.
4. Ensure you have Firebase set up in the project. You’ll need to create a Firebase project and download the `GoogleService-Info.plist` file.

## Getting Started

1. **Login**: Users can log in with their email and password using Firebase Authentication.
2. **Register**: Users can sign up by providing the required details, which are saved in Firebase Authentication.

## Folder Structure

ThreadsClone/
│
├── App/               # Application setup and configuration
├── Core/              # Core functionalities shared across the app
├── Extensions/        # Custom extensions to standard system classes
├── Model/             # Data models representing app data
├── Services/          # Service classes for Firebase interaction
└── Utils/             # Utility functions and helpers

## Future Improvements

- Implement the main Threads feed, Explore, and Activity views.
- Add profile creation and editing.
- Add support for creating, liking, and sharing threads.
- Integrate Firestore for storing user posts and data.
- Add unit tests and UI tests.
