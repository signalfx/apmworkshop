const tracer = require('signalfx-tracing').init()
var http = require('http');

function httpget() {
    http.get(options,  function(res) {
        console.log("statusCode: ", res.statusCode); //nothing
        console.log("headers: ", res.headers); //nothing

        res.on('data', function(d) {
            process.stdout.write(d);
        });

    }).on('error', function(e) {
        console.error(e);
    });
    console.log("This gets logged");
};

options = {
            hostname: 'localhost',
            port: 5000,
            path: '/echo'
        };

// 250ms delay
var interval = 250;

for (var i = 0; i <=100000; i++) {
    setTimeout( function (i) {
        httpget();
    }, interval * i, i);
}
