var promClient = require('prom-client');

const requestCounter = new promClient.Counter({
  name: 'homepage_request_counter',
  help: 'Total number of requests on the homepage',
});

const requestCounterHello = new promClient.Counter({
  name: 'hello_request_counter',
  help: 'Total number of requests on the hello api',
});

const requestCounterDelayed = new promClient.Counter({
  name: 'delayed_request_counter',
  help: 'Total number of requests on the delayed api',
});

const bitcoinPriceMetric = new promClient.Gauge({
  name: 'bitcoin_price_eur',
  help: 'Current price of Bitcoin in EUR',
});

const randomUserGender = new promClient.Counter({
  name: 'random_user_gender',
  help: 'Counts the number of people with a specific gender',
  labelNames: ['gender'],
});

const randomUserAge = new promClient.Histogram({
  name: 'random_user_age',
  help: 'Age of random users',
  labelNames: ['range'],
});

// Crea un istanza di un istogramma per registrare la durata delle richieste HTTP
const responseTimeMetric = new promClient.Histogram({
  name: 'http_request_duration_seconds',
  help: 'Duration of HTTP requests in seconds',
  labelNames: ['method', 'path', 'response_code'],
});

module.exports = {
  requestCounter,
  requestCounterHello,
  requestCounterDelayed,
  bitcoinPriceMetric,
  randomUserGender,
  randomUserAge,
  responseTimeMetric
}