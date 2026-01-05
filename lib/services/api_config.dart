class ApiConfig {
  // Production Vercel URL
  static const String baseUrl = 'https://brids-crud-sample.vercel.app/api';
  
  // For local development, change to:
  // static const String baseUrl = 'http://localhost:3001/api';
  // For Android emulator: 'http://10.0.2.2:3001/api'
  // For iOS simulator: 'http://localhost:3001/api'
  
  // API Endpoints
  static String get authLogin => '$baseUrl/auth/login';
  static String get birdsV1 => '$baseUrl/v1/birds';
  static String get birdsV2 => '$baseUrl/v2/birds';
  
  // Default credentials
  static const String defaultUsername = 'bpi';
  static const String defaultPassword = 'bpi2023';
  
  // Use v1 (no auth) or v2 (with auth)
  static const bool useAuthVersion = true;
  
  static String get birdsEndpoint => useAuthVersion ? birdsV2 : birdsV1;
}

