const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 3005;
// Adjust path to point to platform/sub/public from scripts directory
// scripts/ is in plasmic-local-setup/scripts
// so ../../platform/sub/public
const ROOT = path.resolve(__dirname, '../../platform/sub/public');

const mimeTypes = {
  '.html': 'text/html',
  '.js': 'text/javascript',
  '.css': 'text/css',
  '.json': 'application/json',
  '.png': 'image/png',
  '.jpg': 'image/jpg',
  '.gif': 'image/gif',
  '.svg': 'image/svg+xml',
};

console.log(`Starting Host Server...`);
console.log(`Serving: ${ROOT}`);

http.createServer((req, res) => {
  // CORS is crucial for Plasmic Studio to load the host
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    res.writeHead(200);
    res.end();
    return;
  }

  // Sanitize path to prevent directory traversal
  const safePath = path.normalize(req.url).replace(/^(\.\.[/\\])+/, '');
  let filePath = path.join(ROOT, safePath);
  
  // If requesting root, try index.html (though we care about static/host.html)
  if (req.url === '/') {
      filePath = path.join(ROOT, 'index.html');
  }

  const extname = String(path.extname(filePath)).toLowerCase();
  const contentType = mimeTypes[extname] || 'application/octet-stream';

  fs.readFile(filePath, (error, content) => {
    if (error) {
      if(error.code == 'ENOENT') {
        // console.log(`404: ${filePath}`);
        res.writeHead(404);
        res.end('404 File Not Found');
      } else {
        console.error(`500: ${error.code} for ${filePath}`);
        res.writeHead(500);
        res.end('500: '+error.code);
      }
    } else {
      res.writeHead(200, { 'Content-Type': contentType });
      res.end(content, 'utf-8');
    }
  });
}).listen(PORT, '0.0.0.0', () => {
  console.log(`Host Server running at http://localhost:${PORT}/`);
});
