var io = require('socket.io-client')
socket = io.connect('wss://skynet.im');

socket.on('connect', function(){
  console.log('Requesting websocket connection to SkyNet');

  socket.on('notReady', function(data){
    if (data.status == 401){
      console.log('Device not authenticated with SkyNet');
    }
  });
});
