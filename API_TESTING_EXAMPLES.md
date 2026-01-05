# API Testing Examples

Test these endpoints using curl, Postman, or your Flutter app.

## 🔐 Step 1: Authentication

### Login Request

```bash
curl -X POST http://localhost:3001/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "bpi",
    "password": "bpi2023"
  }'
```

### Expected Response

```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImJwaSIsImlhdCI6MTY3..."
}
```

**💡 Copy the `access_token` value for use in the next requests.**

---

## 🐦 Step 2: Birds CRUD Operations

Replace `YOUR_TOKEN_HERE` with the token from Step 1.

### Get All Birds

```bash
curl -X GET http://localhost:3001/api/v2/birds \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### Get Single Bird (ID: 1)

```bash
curl -X GET http://localhost:3001/api/v2/birds/1 \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### Create New Bird

```bash
curl -X POST http://localhost:3001/api/v2/birds \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "BirdMyanmarName": "ငှက်စမ်းသပ်",
    "BirdEnglishName": "Test Bird",
    "Description": "This is a test bird created via API",
    "ImagePath": "img/birds/img/test.jpg"
  }'
```

### Update Bird (Full Update - PUT)

```bash
curl -X PUT http://localhost:3001/api/v2/birds/1 \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "BirdMyanmarName": "ငှက်စိမ်းရင်ဝါ (Updated)",
    "BirdEnglishName": "Orange-bellied Leafbird (Updated)",
    "Description": "Updated description",
    "ImagePath": "img/birds/img/1_updated.jpg"
  }'
```

### Update Bird (Partial Update - PATCH)

```bash
curl -X PATCH http://localhost:3001/api/v2/birds/1 \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "Description": "Only updating the description"
  }'
```

### Delete Bird

```bash
curl -X DELETE http://localhost:3001/api/v2/birds/1 \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

---

## 📱 Flutter App Testing Flow

### 1. Start Backend
```bash
cd birds/brids-nest-js-crud-sample
npm run start:dev
```

### 2. Run Flutter App
```bash
flutter run
```

### 3. Test Features

#### ✅ Login
1. App opens to login screen
2. Username and password are pre-filled
3. Click "Login" button
4. Should navigate to birds list

#### ✅ View Birds List
1. After login, see list of birds
2. Each bird shows English name and Myanmar name
3. Pull down to refresh

#### ✅ View Bird Details
1. Tap any bird card
2. See full details including description
3. See image path and bird ID

#### ✅ Create New Bird
1. Tap the "+" floating button
2. Fill in all fields:
   - English Name: "Kingfisher"
   - Myanmar Name: "ငှက်သတင်းကြား"
   - Description: "A colorful bird"
   - Image Path: "img/birds/img/kingfisher.jpg"
3. Tap "Create Bird"
4. Success message appears
5. New bird appears in list

#### ✅ Edit Bird
1. From birds list, tap edit icon
2. Modify any field
3. Tap "Update Bird"
4. Success message appears
5. Changes reflected in list

#### ✅ Delete Bird
1. From birds list, tap delete icon
2. Confirmation dialog appears
3. Tap "Delete"
4. Success message appears
5. Bird removed from list

#### ✅ Error Handling
1. Stop the backend server
2. Try to refresh birds list
3. Should see error message
4. Tap "Retry" button
5. Error persists (expected)
6. Start backend again
7. Tap "Retry"
8. Birds should load

#### ✅ Logout
1. Tap logout icon in top right
2. Should navigate back to login screen
3. Token is cleared

---

## 🧪 Postman Collection

### Setup
1. Create new collection "Birds API"
2. Add environment variable `token`
3. Import these requests:

### 1. Login
```
POST http://localhost:3001/api/auth/login
Body (JSON):
{
  "username": "bpi",
  "password": "bpi2023"
}

Tests (save token):
pm.environment.set("token", pm.response.json().access_token);
```

### 2. Get All Birds
```
GET http://localhost:3001/api/v2/birds
Headers:
Authorization: Bearer {{token}}
```

### 3. Create Bird
```
POST http://localhost:3001/api/v2/birds
Headers:
Authorization: Bearer {{token}}
Content-Type: application/json

Body (JSON):
{
  "BirdMyanmarName": "Test Bird",
  "BirdEnglishName": "Test Bird",
  "Description": "Test",
  "ImagePath": "img/test.jpg"
}
```

---

## 🔍 Expected Responses

### Success Responses

#### Get All Birds (200 OK)
```json
[
  {
    "Id": 1,
    "BirdMyanmarName": "ငှက်စိမ်းရင်ဝါ",
    "BirdEnglishName": "Orange-bellied Leafbird",
    "Description": "A beautiful green bird...",
    "ImagePath": "img/birds/img/1.jpg"
  },
  ...
]
```

#### Create/Update Bird (200/201 OK)
```json
{
  "Id": 21,
  "BirdMyanmarName": "ငှက်စမ်းသပ်",
  "BirdEnglishName": "Test Bird",
  "Description": "This is a test bird",
  "ImagePath": "img/birds/img/test.jpg"
}
```

#### Delete Bird (200 OK)
```json
{
  "Id": 21,
  "BirdMyanmarName": "ငှက်စမ်းသပ်",
  "BirdEnglishName": "Test Bird",
  "Description": "This is a test bird",
  "ImagePath": "img/birds/img/test.jpg"
}
```

### Error Responses

#### 401 Unauthorized
```json
{
  "statusCode": 401,
  "message": "Unauthorized"
}
```
**Solution:** Login again to get a fresh token

#### 404 Not Found
```json
{
  "statusCode": 404,
  "message": "Bird not found"
}
```
**Solution:** Check if bird ID exists

#### 400 Bad Request
```json
{
  "statusCode": 400,
  "message": ["BirdEnglishName should not be empty"],
  "error": "Bad Request"
}
```
**Solution:** Provide all required fields

---

## 🎯 Integration Test Checklist

- [ ] Backend starts successfully
- [ ] Login endpoint returns token
- [ ] Token stored in app
- [ ] Get all birds works
- [ ] Get single bird works
- [ ] Create bird adds to list
- [ ] Update bird modifies data
- [ ] Delete bird removes from list
- [ ] 401 errors handled gracefully
- [ ] Network errors show retry option
- [ ] Pull to refresh works
- [ ] Logout clears token
- [ ] Login required after logout

---

## 🐛 Troubleshooting

### Connection Refused
- ✅ Backend is running
- ✅ Using correct URL (10.0.2.2 for Android emulator)
- ✅ Internet permission in AndroidManifest.xml

### 401 Unauthorized
- ✅ Token exists and is valid
- ✅ Authorization header is included
- ✅ Token not expired (login again)

### Empty Birds List
- ✅ Backend has data loaded
- ✅ Check backend console for errors
- ✅ Try accessing API directly in browser/Postman

---

**Happy Testing! 🚀**

