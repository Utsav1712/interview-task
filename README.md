# ✈️ Travel Booking App — Interview Task

A beautifully crafted **Flutter travel booking UI** app featuring an animated splash screen and a fully designed home screen with hotel/flight discovery, trending deals, and life experiences.

---

## 📱 Screenshots & Features

### Animated Splash Screen
- Gradient panel (`#13C2C2 → #5E29CD`) slides upward revealing the logo
- Logo fades & scales in with smooth `easeOut` animation
- Palm tree decorations with opacity effect
- Custom `_BottomWaveClipper` for a wave-shaped panel edge
- Auto-navigates to Home after ~3.8 seconds

### Home Screen
- **Gradient Header** — Cyan-to-purple gradient with palm tree asset overlay
- **Category Tabs** — Horizontally scrollable tabs: Hotels, Flights, Life Experience, Cars, Cruises
- **Smart Search Card** — Destination, Date (with `DateRangePicker`), and Travelers fields with a gradient Search button
- **Recent Searches** — Horizontal cards showing last searched hotels/flights
- **Hot & Trending** — Tabbed section ("The Club Select" / "The Club Hotel") with hotel cards
- **Life Experience®** — Curated experience cards with cruise packages
- **Flash Deals** — Dark-themed section with daily hotel deals
- **Promo Banners** — Travel Visa CTA and eSIM promotional banner
- **Custom Bottom Navigation Bar** — Home, My Trips, Wishlist, Account with a center notch FAB
- **Sparkle FAB** — Floating action button centered in the notched bottom bar

---

## 🏗️ Project Architecture

```
lib/
├── main.dart                  # App entry point, ScreenUtil initialization
├── core/
│   ├── constants/
│   │   ├── app_assets.dart    # All image/icon asset paths
│   │   ├── app_colors.dart    # App-wide color palette
│   │   └── app_text_styles.dart # Typography scale (headline, body, label)
│   ├── routes/
│   │   └── app_routes.dart    # Named route definitions & route generator
│   └── theme/
│       └── app_theme.dart     # Material 3 light theme configuration
├── screens/
│   ├── splash/
│   │   └── splash_screen.dart # Animated splash with gradient panel
│   └── home/
│       └── home_screen.dart   # Main home UI (search, listings, deals)
└── widgets/
    ├── category_item.dart     # Category tab chip (Hotels, Flights, etc.)
    ├── custom_button.dart     # Reusable gradient/outline button
    ├── experience_card.dart   # Life Experience listing card
    ├── flash_deal_card.dart   # Flash deal hotel card
    ├── search_input_field.dart # Search form field with icon
    ├── section_header.dart    # Section title + subtitle header
    └── trending_card.dart     # Hot & Trending hotel card
```

---

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| **Flutter** | Cross-platform UI framework |
| **Dart** `^3.10.3` | Programming language |
| **Material 3** | Design system |
| **provider** `^6.1.2` | State management |
| **flutter_screenutil** `^5.9.3` | Responsive sizing (`360×690` design base) |
| **intl** `^0.20.2` | Date formatting for `DateRangePicker` |

---

## 🎨 Design System

### Color Palette
| Token | Hex | Usage |
|---|---|---|
| `primary` | `#6C63FF` | Buttons, active states |
| `accent` | `#03DAC6` | Secondary accents |
| `gradient start` | `#32C5FF` / `#13C2C2` | Header & splash gradient |
| `gradient end` | `#5E29CD` | Header & splash gradient |
| `background` | `#F5F5F5` | App background |
| `error` | `#B00020` | Error states |

### Typography
- **Font Family**: Roboto
- **Scale**: `displayLarge` (56sp) → `headlineLarge` (28sp) → `headlineMedium` (22sp) → `headlineSmall` (18sp) → `bodyLarge` (16sp) → `bodyMedium` (14sp) → `bodySmall` (12sp)
- All sizes use `flutter_screenutil` `.sp` extension for responsiveness

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `>=3.10.3`
- Dart SDK `>=3.10.3`
- Android Studio / Xcode / VS Code with Flutter extension

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd interview_task

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Platform Support
| Platform | Status |
|---|---|
| Android | ✅ Supported |
| iOS | ✅ Supported |
| Web | ✅ Supported |
| macOS | ✅ Supported |
| Windows | ✅ Supported |
| Linux | ✅ Supported |

---

## 📂 Assets

All assets are located under `assets/images/`:

| Asset | Description |
|---|---|
| `logo.png` | App logo (revealed on splash) |
| `palm_trees.png` | Decorative palm trees (splash + header) |
| `sparkle_icon.png` | Central FAB and promo icon |
| `esim_banner.png` | eSIM promotional banner |
| `resort.png` | Trending hotel card image |
| `cruise.png` | Life Experience card image |
| `living_room.png` | Flash deals hotel image |
| `building.png` | Hotels category icon |
| `airplane.png` | Flights category icon |
| `ship.png` | Cruises category icon |
| `taxi.png` | Cars category icon |
| `location.png` | Life Experience category icon |
| `ticket.png` | Ticket icon |

---

## 🗺️ Navigation

App uses **named route navigation** via `AppRoutes`:

```
/ (splash)  →  /home
```

| Route | Screen |
|---|---|
| `/` | `SplashScreen` — animated intro |
| `/home` | `HomeScreen` — main travel discovery UI |

---

## 📐 Responsive Design

The app uses `flutter_screenutil` with a **design base of `360×690`** logical pixels, ensuring the UI scales correctly across all device sizes. All sizing values use `.w` (width), `.h` (height), `.r` (radius), and `.sp` (font size) extensions.

---

## 🧩 Key Widgets

| Widget | Description |
|---|---|
| `CategoryItem` | Tappable category chip with icon and label, supports selected state |
| `SearchInputField` | Form field with leading icon, label, and optional `onTap` override |
| `SectionHeader` | Bold title with optional subtitle for content sections |
| `TrendingCard` | Hotel card with image, badge, rating, and location |
| `ExperienceCard` | Cruise/experience card with price overlay |
| `FlashDealCard` | Dark-themed hotel deal card with rating badge |
| `CustomButton` | Reusable button supporting gradient and outline variants |

---

## 🔧 Development

```bash
# Run with hot reload
flutter run

# Run on specific device
flutter run -d <device-id>

# List available devices
flutter devices

# Analyze code
flutter analyze

# Run tests
flutter test

# Build release APK
flutter build apk --release

# Build iOS release
flutter build ipa --release
```

---

## 📋 Project Info

- **Version**: `1.0.0+1`
- **Package**: `com.task.interview_task`
- **Min Dart SDK**: `^3.10.3`
- **Design Base**: `360×690` (ScreenUtil)
