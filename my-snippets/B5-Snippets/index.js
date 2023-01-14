const http = require('http')
const fs = require('fs');
const PORT = 7000;


http.createServer(function (request, response) {
  if (request.url == '/') {
    fs.readFile('./templates/demo.html', function(err, data) {
      response.writeHead(200, {'Content-Type': 'text/html'});
      response.write(data);
      return response.end();
    });
  }
  else{
    return response.end('Invalid request');
  }
}).listen(PORT);