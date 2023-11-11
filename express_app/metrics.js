var promClient = require('prom-client');

const requestCounter = new promClient.Counter({
  name: 'homepage_request_counter',
  help: 'Total number of requests on the homepage',
});

const bitcoinPriceMetric = new promClient.Gauge({
  name: 'bitcoin_price_eur',
  help: 'Current price of Bitcoin in EUR',
});

const randomUserGauge = new promClient.Gauge({
  name: 'random_user',
  help: 'Counts the number of people with a specific gender',
  labelNames: ['gender', 'age'],
});

// Crea un istanza di un istogramma per registrare la durata delle richieste HTTP
const responseTimeMetric = new promClient.Histogram({
  name: 'http_request_duration_seconds',
  help: 'Duration of HTTP requests in seconds',
  labelNames: ['method', 'path', 'response_code'],
});

module.exports = {
  requestCounter,
  bitcoinPriceMetric,
  randomUserGauge,
  responseTimeMetric
}