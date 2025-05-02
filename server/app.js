const express = require('express');
const socketIO = require('socket.io');
const cors = require('cors');  // Add this line

const app = express();
const PORT = process.env.PORT || 4000;

// Enable CORS
app.use(cors());  // Use cors middleware

const server = app.listen(PORT, () => {
  console.log('Server is running on port', PORT);
});

const io = socketIO(server);

io.on('connection', (socket) => {
  console.log('Client connected:', socket.id);
  socket.on('disconnect', () => {
    console.log('Client disconnected:', socket.id);
  });

  socket.on('message', (data) => {
    console.log('Message received:', data); // should now log JSON from Flutter
    io.emit('message', data); // broadcast to all clients
});

});
