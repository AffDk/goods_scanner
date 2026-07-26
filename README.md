# Goods Scanner

Scan product barcodes or take photos to discover which countries are involved in a product's supply chain.

## How It Works

1. **Scan a barcode** or **take a photo** of a product
2. The app looks up product data via Open Food Facts API
3. Google Gemini AI analyzes the product and its supply chain
4. You see the top 3 countries with involvement percentages
5. The "benefiting country" shows where the profit likely flows

## Prerequisites

- Flutter SDK (see [flutter.dev](https://flutter.dev/docs/get-started/install/windows))
- A Gemini API key (see [docs/API_SETUP.md](docs/API_SETUP.md))

## Setup

```bash
# Clone the project
cd goods_scanner

# Set up your API key
cp .env.example .env
# Edit .env and paste your Gemini API key

# Install dependencies
flutter pub get
```

## Running

```bash
# Run on connected device / emulator
flutter run

# Run in debug mode
flutter run --debug
```

## Testing

```bash
flutter test
```

## Building APK

```bash
# Debug APK (install directly on phone)
flutter build apk --debug

# Release APK (requires signing)
flutter build apk --release
```

The APK will be at `build/app/outputs/flutter-apk/app-debug.apk`.

## Project Structure

```
lib/
├── main.dart                     # App entry point
├── config/env.dart               # Environment config (API keys)
├── models/
│   ├── product.dart              # Product data model
│   └── country_involvement.dart  # Country analysis model
├── services/
│   ├── barcode_lookup_service.dart  # Open Food Facts API
│   ├── gemini_service.dart          # Google Gemini AI
│   └── product_analysis_service.dart# Orchestrator
├── screens/
│   ├── home_screen.dart          # Main menu
│   ├── scanner_screen.dart       # Barcode scanner
│   ├── camera_screen.dart        # Photo capture
│   └── results_screen.dart       # Country breakdown
└── widgets/
    ├── country_card.dart         # Country result card
    ├── percentage_bar.dart       # Progress indicator
    └── loading_overlay.dart      # Loading state
```

## APIs Used

| API | Key Needed | Purpose |
|---|---|---|
| Open Food Facts | No | Food product barcode lookup |
| Google Gemini 3.5 Flash | Yes | Supply chain analysis |

## Notes

- Country involvement percentages are AI estimates based on global supply chain knowledge
- Results are for educational/informational purposes
- Internet connection required
