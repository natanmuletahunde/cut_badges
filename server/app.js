const express = require('express');
const socketIO = require('socket.io');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 4000;

app.use(cors());

const server = app.listen(PORT, () => {
  console.log('Server is running on port', PORT);
});

const io =require('socket.io')(server)
 const connectedUser = new Set();
io.on('connection', (socket) => {
  console.log('Client connected:', socket.id);
  io.emit('connected-user', connectedUser.size) // Send a welcome message to the connected client
  connectedUser.add(socket.id)

  socket.on('message', (data) => {
    console.log(JSON.stringify(data, null, 2));
    socket.broadcast.emit('message-receive' , data) // Pretty print the message
  });

  socket.on('disconnect', () => {
    console.log('Client disconnected:', socket.id);
    io.emit('connected-user', connectedUser.size) // Send a welcome message to the connected client

  });
});
