# 📱 Flutter Socket Mobile App

A real-time mobile chat application built using **Flutter**, **Socket.IO**, and **Node.js**, with state management powered by **GetX**.

---

## 🚀 Features

- ✅ Real-time messaging with WebSocket (Socket.IO)
- ✅ Reactive UI with GetX state management
- ✅ Cross-platform mobile support (Android/iOS)
- ✅ Node.js Socket.IO backend

---

## 🛠️ Tech Stack

### Client

- **Flutter** – UI toolkit for building natively compiled applications
- **Dart** – Programming language for Flutter
- **GetX** – State management solution for Flutter
- **Socket.IO Client** – Real-time communication with the server

### Server

- **Node.js** – Backend runtime environment
- **Express.js** – Web framework for Node.js
- **Socket.IO** – Real-time bidirectional event-based communication

---

## 📦 Installation

### 🔧 Client (Flutter)

```bash
git clone https://github.com/yourusername/flutter-socket-mobile-app.git
cd flutter-socket-mobile-app
flutter pub get
flutter run

    Make sure to run on a mobile emulator or connected device.

🔌 Server (Node.js)

cd server
npm install
node index.js

    Ensure that your mobile device or emulator can access the IP address where your Node.js server is running.

⚙️ Socket Server (Node.js)

Example: index.js

const express = require('express');
const http = require('http');
const { Server } = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = new Server(server, {
  cors: {
    origin: '*',
  },
});

io.on('connection', (socket) => {
  console.log('User connected:', socket.id);

  socket.on('send-message', (data) => {
    io.emit('message-received', data);
  });

  socket.on('disconnect', () => {
    console.log('User disconnected:', socket.id);
  });
});

const PORT = 3000;
server.listen(PORT, () => {
  console.log(`Socket.IO server running on port ${PORT}`);
});

📱 Flutter Socket Client (Example)

final socket = IO.io('http://<your-ip>:3000', <String, dynamic>{
  'transports': ['websocket'],
  'autoConnect': true,
});

    Replace <your-ip> with your server's local or public IP.

📁 Folder Structure

flutter-socket-mobile-app/
├── lib/
│   ├── controllers/
│   ├── models/
│   ├── services/
│   └── views/
├── server/             # Node.js backend
│   └── index.js
└── README.md
