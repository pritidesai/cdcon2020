var http = require('http')

var port = 4000

var server = http.createServer(function (request, response) {
    response.writeHead(200, {'Content-Type': 'text/plain'})
    var t = getDateTime()
    response.end('Hello cdCon 2020!\nIts ' + t + ' in my world.\nHow about in your world?\n')
})

server.listen(port)

console.log('Server running at http://localhost:' + port)

function getDateTime() {
    var dateFormat = require('dateformat');
    var date = new Date();
    var utcDate = new Date(date.toUTCString());
    utcDate.setHours(utcDate.getHours()-7);
    var usDate = new Date(utcDate);
    var prettyDate = dateFormat(usDate, "dddd, mmmm dS, yyyy, h:MM:ss TT");
    return prettyDate;
}

