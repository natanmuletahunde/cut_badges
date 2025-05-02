# 📱 Flutter Socket Mobile App

A real-time chat mobile application built with **Flutter** and **Socket.IO** using the **GetX** state management package.

## 🚀 Features

- ✅ Real-time messaging with Socket.IO
- ✅ Reactive state management with GetX
- ✅ Beautiful and responsive UI
- ✅ Easily scalable architecture

## 🛠️ Tech Stack

- **Flutter** – Cross-platform mobile app framework
- **Socket.IO** – Real-time communication protocol
- **GetX** – Lightweight and powerful state management
- **Dart** – Programming language for Flutter

## 🖼️ Screenshots

> *(Optional: Insert screenshots or screen recordings of your app here)*

## 📦 Installation

```bash
git clone https://github.com/yourusername/flutter-socket-mobile-app.git
cd flutter-socket-mobile-app
flutter pub get

▶️ Running the App

    Ensure you have an emulator or real device connected.

    Start the Socket.IO server (if you have one).

    Run the app:

flutter run

    You can also run it from VS Code or Android Studio by selecting a device and pressing F5.

🔌 Socket Server (Optional)

If you're using a custom Socket.IO server, be sure to update the socket URL in your code (e.g. in socket_service.dart).

Example:

final socket = IO.io('http://your-server-ip:3000', <String, dynamic>{
  'transports': ['websocket'],
  'autoConnect': true,
});

📁 Folder Structure (Optional)

lib/
│
├── controllers/         # GetX controllers
├── models/              # Data models (e.g., Message)
├── services/            # Socket service
├── views/               # UI components and screens
└── main.dart  
