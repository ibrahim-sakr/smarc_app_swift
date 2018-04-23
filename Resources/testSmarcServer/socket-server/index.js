var app = require('http').createServer(handler)
var io = require('socket.io')(app);
var fs = require('fs');

app.listen(3101);

function handler (req, res) {
    res.writeHead(200);
    res.end("Hello World");
}

io.on('connection', function (socket) {
    console.log("Device Connected");
    var status = true;
    setInterval(() => {
        status = !status;
        socket.emit('dataIncome', {
            type: "light",
            data: {
                _id: "5ace0839ce77ed0f5efd6def",
                name: "point name2",
                status: status,
                roomId: "room id",
                nodeI: "127.0.0.1",
                nodeName: "node name",
                nodeStatus: true
            }
        });
    }, 4000);

    socket.on('disconnect', function(){
        console.log('Device Disconnected');
    });
});
