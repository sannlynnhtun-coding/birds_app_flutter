# Birds App Flutter - API Integration

This Flutter app integrates with the NestJS Birds CRUD API.

## Features

✅ **JWT Authentication** - Secure login with JWT token storage  
✅ **View All Birds** - Browse complete birds collection  
✅ **Bird Details** - View detailed information about each bird  
✅ **Create Bird** - Add new birds to the collection  
✅ **Update Bird** - Edit existing bird information  
✅ **Delete Bird** - Remove birds from the collection  
✅ **Pull to Refresh** - Refresh bird list by pulling down  
✅ **Error Handling** - Graceful error messages with retry options  

## Project Structure

```
lib/
├── main.dart                    # App entry point with providers
├── models/
│   └── bird.dart               # Bird data model
├── services/
│   ├── api_config.dart         # API configuration & endpoints
│   ├── auth_service.dart       # Authentication service
│   └── bird_service.dart       # Birds CRUD operations
├── providers/
│   ├── auth_provider.dart      # Authentication state management
│   └── bird_provider.dart      # Birds state management
└── screens/
    ├── login_screen.dart       # Login page
    ├── birds_list_screen.dart  # Birds list page
    ├── bird_detail_screen.dart # Bird details page
    └── bird_form_screen.dart   # Create/Edit bird page
```

## Setup Instructions

### 1. Install Dependencies

```bash
flutter pub get
```

This will install:
- `http` - For making API calls
- `shared_preferences` - For storing JWT token
- `provider` - For state management

### 2. Configure API URL

Open `lib/services/api_config.dart` and update the `baseUrl`:

**For Android Emulator:**
```dart
static const String baseUrl = 'http://10.0.2.2:3001/api';
```

**For iOS Simulator:**
```dart
static const String baseUrl = 'http://localhost:3001/api';
```

**For Physical Device:**
```dart
static const String baseUrl = 'http://YOUR_COMPUTER_IP:3001/api';
```

To find your computer's IP:
- Windows: `ipconfig` (look for IPv4 Address)
- Mac/Linux: `ifconfig` or `ip addr show`

### 3. Start the NestJS Backend

Navigate to the NestJS project and start the server:

```bash
cd birds/brids-nest-js-crud-sample
npm install
npm run start:dev
```

The API should be running at `http://localhost:3001`

### 4. Run the Flutter App

```bash
flutter run
```

## API Endpoints Used

### Authentication
- **POST** `/api/auth/login` - Login and get JWT token

### Birds (v2 - with authentication)
- **GET** `/api/v2/birds` - Get all birds
- **GET** `/api/v2/birds/:id` - Get bird by ID
- **POST** `/api/v2/birds` - Create new bird
- **PUT** `/api/v2/birds/:id` - Update bird (full)
- **PATCH** `/api/v2/birds/:id` - Update bird (partial)
- **DELETE** `/api/v2/birds/:id` - Delete bird

## Default Login Credentials

- **Username:** `bpi`
- **Password:** `bpi2023`

These are pre-filled in the login screen for convenience.

## How It Works

### Authentication Flow

1. User logs in with username and password
2. App sends credentials to `/api/auth/login`
3. Server returns JWT access token
4. Token is stored locally using `shared_preferences`
5. Token is included in all subsequent API requests as Bearer token
6. User stays logged in until they logout

### State Management

The app uses **Provider** for state management:

- **AuthProvider** - Manages authentication state
  - Login/logout functionality
  - Token storage and retrieval
  - Login status tracking

- **BirdProvider** - Manages birds data state
  - Fetch all birds
  - Create, update, delete birds
  - Loading and error states

### Data Flow

```
Screen → Provider → Service → API
  ↓         ↓         ↓        ↓
UI ← State ← Data ← Response ← Server
```

## Troubleshooting

### Cannot connect to API

1. **Check API URL** in `lib/services/api_config.dart`
2. **Verify backend is running** - Visit `http://localhost:3001` in browser
3. **Check network permissions** in `AndroidManifest.xml`:
   ```xml
   <uses-permission android:name="android.permission.INTERNET"/>
   ```

### 401 Unauthorized Error

- Token might have expired
- Logout and login again
- Check if authentication is required in `api_config.dart`

### Connection Refused (Android)

- Use `10.0.2.2` instead of `localhost` for Android emulator
- Make sure backend is running on `0.0.0.0` not just `localhost`

### CORS Issues

The NestJS backend has CORS enabled by default. If you still face CORS issues, check `main.ts` in the backend.

## Testing Without Authentication

If you want to test without authentication (using v1 endpoints):

In `lib/services/api_config.dart`, change:
```dart
static const bool useAuthVersion = false; // Use v1 endpoints
```

## API Response Format

### Bird Object
```json
{
  "Id": 1,
  "BirdMyanmarName": "ငှက်စိမ်းရင်ဝါ",
  "BirdEnglishName": "Orange-bellied Leafbird",
  "Description": "A beautiful green bird with yellow belly...",
  "ImagePath": "img/birds/img/1_Orange-belliedLeafbird.jpg"
}
```

### Login Response
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

## Future Enhancements

- [ ] Image loading from backend
- [ ] Search and filter functionality
- [ ] Offline caching
- [ ] Better error messages
- [ ] Form validation improvements
- [ ] Image upload support
- [ ] Dark mode
- [ ] Localization (Myanmar/English)

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0              # HTTP requests
  shared_preferences: ^2.2.2 # Local storage
  provider: ^6.1.1          # State management
```

## License

This project is for educational purposes.

