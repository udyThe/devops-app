const express = require('express');
const client = require('prom-client');

const app = express();
const port = process.env.PORT || 8080;

// Create a custom counter metric
const requestCounter = new client.Counter({
  name: 'http_requests_total',
  help: 'Total number of HTTP requests',
});

app.get('/', (req, res) => {
  requestCounter.inc(); // Increment counter on each request
  res.send('Hello from DevOps App!!!');
});

// Metrics endpoint for Prometheus to scrape
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', client.register.contentType);
  res.end(await client.register.metrics());
});

app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});
