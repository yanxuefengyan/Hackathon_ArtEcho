const http = require('http');
const fs = require('fs');
const path = require('path');

const server = http.createServer((req, res) => {
  let filePath = path.join(__dirname, req.url === '/' ? 'public/index.html' : req.url.substring(1));
  
  fs.readFile(filePath, (err, content) => {
    if (err) {
      res.writeHead(404, { 'Content-Type': 'text/plain' });
      res.end('404 Not Found');
      return;
    }
    
    const ext = path.extname(filePath);
    const contentType = ext === '.html' ? 'text/html' : 
                         ext === '.css' ? 'text/css' :
                         ext === '.js' ? 'application/javascript' : 'text/plain';
    
    res.writeHead(200, { 'Content-Type': contentType });
    res.end(content);
  });
});

server.listen(3001, '127.0.0.1', () => {
  console.log('Simple HTTP server running at http://127.0.0.1:3001');
});