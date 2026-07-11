# Men Store - Flutter E-Commerce Application

A sleek, modern, and responsive men's fashion e-commerce mobile application built with Flutter. The app integrates with a REST API to dynamically fetch and display product catalogs, featuring a polished UI, smart filtering, and rich product detail screens.

## ✨ Features

- 📱 **Sleek UI Design**: Modern and clean design system with custom cards, buttons, and navigation.
- 🔍 **Smart Product Filtering**: Responsive grid layout with quick-action category tabs (All, T-Shirts, Jeans, Shoes) using search keyword scanning (scans titles, descriptions, and category metadata).
- 🛍️ **Product Details Screen**: Full details view with product specifications, pricing, responsive zoom/image galleries, and reviews.
-  **REST API Integration**: Dynamic product loading from external API endpoints using standard Dio clients.
-  **Optimized Performance**: Fast image caching and state management for fluid performance.

## Tech Stack & Architecture

- **Framework**: [Flutter](https://flutter.dev/) (Dart)
- **State Management**: Stateful widgets with optimized local state rebuilds.
- **Networking**: [Dio](https://pub.dev/packages/dio) for asynchronous network requests.
- **Architecture**: Modular feature-based structure (`auth`, `home`, `core`).

## Project Structure

```
lib/
├── core/
│   ├── network/       # API clients and network helpers
│   └── theme/         # AppColors, TextStyles, and theme configs
├── features/
│   ├── auth/          # Authentication flows and pages
│   └── home/          # Home screen, product list, search, details
└── models/            # JSON data parsing and model definitions
```

## Getting Started

Follow these steps to set up and run the project locally.

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (latest stable version)
- Dart SDK
- An Android/iOS Emulator or Physical Device
