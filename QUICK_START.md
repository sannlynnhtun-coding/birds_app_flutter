# Quick Start Guide

## 🚀 Get Started in 3 Steps

### Step 1: Start the Backend API

Open a terminal and run:

```bash
cd birds/brids-nest-js-crud-sample
npm install
npm run start:dev
```

The API will start at `http://localhost:3001`

### Step 2: Configure API URL

Open `lib/services/api_config.dart` and set the correct API URL:

#### For Android Emulator:
```dart
static const String baseUrl = 'http://10.0.2.2:3001/api';
```

#### For iOS Simulator:
```dart
static const String baseUrl = 'http://localhost:3001/api';
```

#### For Physical Device:
Find your computer's IP address:
- Windows: Run `ipconfig` in terminal
- Mac: Run `ifconfig` in terminal
- Look for IPv4 address (e.g., 192.168.1.100)

```dart
static const String baseUrl = 'http://YOUR_IP_ADDRESS:3001/api';
```

### Step 3: Run the App

```bash
flutter pub get
flutter run
```

## 📱 Login

Use these credentials (pre-filled):
- Username: `bpi`
- Password: `bpi2023`

## 🎯 Features to Try

1. ✅ **View Birds List** - See all birds from the API
2. ✅ **View Details** - Tap any bird to see full details
3. ✅ **Add Bird** - Tap the + button to create a new bird
4. ✅ **Edit Bird** - Tap edit icon to modify bird information
5. ✅ **Delete Bird** - Tap delete icon to remove a bird
6. ✅ **Pull to Refresh** - Pull down on the list to refresh
7. ✅ **Logout** - Tap logout icon in the top right

## 🔧 Troubleshooting

### Can't connect to API?

1. Make sure backend is running: Visit `http://localhost:3001` in your browser
2. Check API URL in `lib/services/api_config.dart`
3. For Android emulator, use `10.0.2.2` instead of `localhost`
4. For physical device, ensure phone and computer are on same WiFi

### 401 Unauthorized?

- Logout and login again
- Token might have expired

## 📚 API Endpoints

The app uses these endpoints:

```
POST   /api/auth/login         - Login
GET    /api/v2/birds           - Get all birds
GET    /api/v2/birds/:id       - Get one bird
POST   /api/v2/birds           - Create bird
PUT    /api/v2/birds/:id       - Update bird
DELETE /api/v2/birds/:id       - Delete bird
```

## 🛠️ Tech Stack

- **Flutter** - UI Framework
- **Provider** - State Management
- **HTTP** - API Calls
- **SharedPreferences** - Local Storage (JWT Token)
- **NestJS** - Backend API
- **JWT** - Authentication

## 📖 More Information

See `README_API_INTEGRATION.md` for detailed documentation.

---

**Happy Coding! 🎉**

