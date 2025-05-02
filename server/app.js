const express = require('express');
const socket = require('socket.io-client/lib/socket');

const app = express();
const PORT = process.env.PORT || 4000;
const server = app.listen(PORT, () =>{
    console.log('server is running', PORT)
})

const io = require('socket.io')(server,);
io.on('connection', (socket)=>{
    console.log('connected', socket.id);
})