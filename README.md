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

##  Screenshots

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/58584c6d-7f28-4a68-af6d-456a5b6f71fe" width="180"/></td>
    <td><img src="https://github.com/user-attachments/assets/00298ffc-8701-4816-9fc7-2acfc014e6e5" width="180"/></td>
    <td><img src="https://github.com/user-attachments/assets/66cefb11-298e-48f2-86a3-ac755048ab06" width="180"/></td>
    <td><img src="https://github.com/user-attachments/assets/8ce6db3f-c950-433e-9761-a2238d2c21db" width="180"/></td>
  </tr>
  <tr>
    <td align="center">Login</td>
    <td align="center">Sign Up</td>
    <td align="center">Home</td>
    <td align="center">Home Categories</td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/3060381f-ff8f-475b-9a37-e723ccdddb8e" width="180"/></td>
    <td><img src="https://github.com/user-attachments/assets/bdfb1535-b457-478a-9dcb-7fe70bcbba61" width="180"/></td>
    <td><img src="https://github.com/user-attachments/assets/78b750c0-6cf6-4b4a-b15a-2bd79c39b6da" width="180"/></td>
  </tr>
  <tr>
    <td align="center">T-Shirts</td>
    <td align="center">Shoes</td>
    <td align="center">Product Details</td>
  </tr>
</table>

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
