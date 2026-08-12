# 7 Seers Assignment

This repository contains the implementation of the home screen built specifically for the 7 Seers assignment.

## Features Implemented

- **Dynamic Greeting & Check-In**: The top of the screen changes its messaging based on both user state (first time vs returning) and the actual time of day (e.g. "Morning, Harsh" vs "Evening, Harsh" vs "Welcome").
- **Firestore-Driven Guides**: The "This Week's Guide" section fetches data in real-time from a Cloud Firestore database.
- **Offline Resilience**: The app detects when the user loses connection, displays a sleek `OfflineWrapper` banner, and seamlessly falls back to the last cached data using `shared_preferences`.
- **Custom Scroll Behaviors**: Implemented a `CustomScrollView` with a `SliverAppBar` so the app bar dynamically scrolls away as the user browses their guides.

## Architecture & Tech Stack

I chose a lightweight but strict **Clean Architecture** approach (Domain, Data, Presentation layers) to ensure the data fetching and caching logic remains separate from the UI.

- **State Management**: `flutter_bloc` for predictable, event-driven state changes.
- **Dependency Injection**: `get_it` for decoupling services (Data Sources, Connectivity, SharedPreferences).
- **Backend**: Firebase (`cloud_firestore`, `firebase_core`).
- **Caching**: `shared_preferences` to persist Firestore documents locally for offline access.
- **Network Checking**: `internet_connection_checker_plus` to verify actual internet connection status.

No 3rd-party UI kits were used. Every card, layout, and component was built from standard Flutter widgets.

### A quick note on the "Check-In Done" state
You might notice I left out the final "Done for this week" check-in state shown in the designs. Since the assignment brief didn't specify exactly what triggers a completed check-in, I stuck to the "First Time" and "Returning" states for now to keep things focused. 

If i had clear picture of wht to do, I'd just add a `hasCompletedWeeklyCheckIn` flag to the user's Firebase doc or localstorage and toggle the UI based on that!
