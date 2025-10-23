# 📱 Mini Marketplace App

> Sàn giáo dục trực tuyến - Flutter với Clean Architecture + BLoC Pattern

[![Flutter](https://img.shields.io/badge/Flutter-3.8.1+-02569B)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Firestore-FFCA28)](https://firebase.google.com)

---

## 🎯 Mô Tả

Ứng dụng sàn giáo dục kết nối **giáo viên** và **học viên**, cho phép:

### Giáo viên:
- ✅ Tạo, chỉnh sửa, xóa khóa học
- ✅ Upload ảnh khóa học, thêm video YouTube, PDF
- ✅ Quản lý học viên đã mua
- ✅ Theo dõi đơn hàng
- ✅ Chat hỗ trợ học viên

### Học viên:
- ✅ Xem danh sách khóa học
- ✅ Mua khóa học (thanh toán tự động)
- ✅ Truy cập tài liệu đã mua
- ✅ Chat với giáo viên
- ✅ Xem lịch sử đơn hàng

---

## 🏗️ Kiến Trúc - Clean Architecture

Ứng dụng được xây dựng theo **Clean Architecture** với 3 tầng độc lập:

```
┌─────────────────────────────┐
│  PRESENTATION LAYER         │  ← UI (Pages, Widgets) + BLoC
│  - Hiển thị giao diện       │
│  - Xử lý user input         │
│  - Quản lý state (BLoC)     │
└──────────┬──────────────────┘
           │ Depends on
           ↓
┌─────────────────────────────┐
│  DOMAIN LAYER               │  ← Business Logic (Pure Dart)
│  - Entities (Models)        │
│  - UseCases (Logic)         │
│  - Repository Interfaces    │
└──────────┬──────────────────┘
           │ Implemented by
           ↓
┌─────────────────────────────┐
│  DATA LAYER                 │  ← Dữ liệu + API
│  - Data Sources (Firebase)  │
│  - Models (JSON ↔ Entity)   │
│  - Repository Impls         │
└─────────────────────────────┘
```

**Dependency Rule**: Presentation → Domain ← Data (tầng trong không phụ thuộc tầng ngoài)

---

## 📂 Cấu Trúc Code

```
lib/
├── main.dart                    # Entry point
├── injection_container.dart     # Dependency Injection (GetIt)
│
├── core/                        # CODE DÙNG CHUNG
│   ├── errors/                  # Exceptions & Failures
│   ├── usecases/                # Base UseCase class
│   └── services/                # NotificationService
│
├── data/                        # TẦNG DATA
│   ├── datasources/             # Firebase integration
│   │   ├── auth_remote_datasource.dart
│   │   ├── course_remote_datasource.dart
│   │   ├── order_remote_datasource.dart
│   │   └── chat_remote_datasource.dart
│   ├── models/                  # Data models (JSON ↔ Entity)
│   │   ├── user_model.dart
│   │   ├── course_model.dart
│   │   └── ...
│   └── repositories/            # Repository implementations
│
├── domain/                      # TẦNG DOMAIN (Pure Dart)
│   ├── entities/                # Business entities
│   ├── repositories/            # Repository interfaces
│   └── usecases/                # Business logic
│       ├── auth/                # Login, Register, Logout
│       ├── course/              # CRUD courses
│       ├── order/               # Create/Get orders
│       └── chat/                # Send/Get messages
│
└── presentation/                # TẦNG PRESENTATION
    ├── blocs/                   # BLoC Pattern (State Management)
    │   ├── auth/
    │   ├── course/
    │   ├── order/
    │   └── chat/
    └── pages/                   # UI Screens
        ├── auth/                # Login, Register
        ├── home/                # Main navigation
        ├── course/              # Course pages
        └── chat/                # Chat screens
```

---

## 🔄 Luồng Hoạt Động (BLoC Pattern)

```
User Action (nhấn button)
    ↓
Event (LoginEvent, CreateCourseEvent, ...)
    ↓
BLoC (xử lý logic)
    ↓
UseCase (business logic)
    ↓
Repository Interface (domain)
    ↓
Repository Implementation (data)
    ↓
DataSource (Firebase API call)
    ↓
State (AuthState, CourseState, ...)
    ↓
UI Update (rebuild widget)
```

**Ví dụ: Đăng nhập**
1. User nhấn button "Login"
2. UI gửi `LoginEvent` tới `AuthBloc`
3. `AuthBloc` gọi `LoginUseCase`
4. `LoginUseCase` gọi `AuthRepository.login()`
5. `AuthRepositoryImpl` gọi Firebase Auth
6. Kết quả trả về qua `AuthState`
7. UI nhận state và rebuild

---

## 🗄️ Database (Firestore)

```javascript
// Collection: users
users/{userId}
{
  id, email, name, role, createdAt
}

// Collection: courses
courses/{courseId}
{
  id, title, description, price,
  teacherId, imageUrl, youtubeUrl, pdfUrl,
  enrolledCount, isActive, createdAt
}

// Collection: orders
orders/{orderId}
{
  id, userId, courseId, courseName,
  amount, status, createdAt
}

// Collection: messages (Chat metadata)
messages/{chatId}  // chatId = "userId1_userId2"
{
  participants[], lastMessage,
  lastMessageTime, unreadCount_userId1
}

// Subcollection: Chat messages
messages/{chatId}/chats/{messageId}
{
  id, senderId, receiverId,
  message, timestamp, isRead
}
```

---

## 🔧 Công Nghệ Sử Dụng

**Core:**
- `firebase_auth` - Xác thực người dùng
- `cloud_firestore` - Database real-time
- `firebase_storage` - Lưu trữ file
- `firebase_messaging` - Push notification

**State Management:**
- `flutter_bloc` ^8.1.6 - BLoC Pattern
- `get_it` ^8.0.2 - Dependency Injection

**UI:**
- `image_picker` - Chọn ảnh
- `cached_network_image` - Cache ảnh
- `url_launcher` - Mở link

---

## 🚀 Hướng Dẫn Chạy

### 1. Yêu cầu:
- Flutter SDK: **3.8.1+**
- Dart SDK: **3.0.0+**
- Android Studio / VS Code

### 2. Cài đặt:
```bash
# Clone project
git clone <repository-url>
cd mini_marketplace_app

# Cài dependencies
flutter pub get

# Generate localization
flutter gen-l10n
```

### 3. Chạy app:
```bash
flutter run
```

### 4. Build APK:
```bash
flutter build apk --release
```
APK sẽ được tạo tại: `build/app/outputs/flutter-apk/app-release.apk`

---

## 👤 Tài Khoản Test

**Giáo viên:**
```
Email: teacher@gmail.com
Password: 123456
```

**Học viên:**
```
Email: student@gmail.com
Password: 123456
```

---

##  Lưu Ý

1. **Push notification giữa thiết bị**: Cần Firebase Blaze Plan (trả phí) để deploy Cloud Functions
2. **Upload ảnh**: Dùng imgbb.com (free tier) nên tốc độ load có thể hơi chậm
3. **Thanh toán**: Chế độ demo - tự động hoàn thành đơn hàng

---


