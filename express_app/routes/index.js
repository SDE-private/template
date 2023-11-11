var express = require('express');
var debug = require('debug')('express-app:server');
var promClient = require('prom-client');
var fetch = require('node-fetch');
const crypto = require('crypto');
const metrics = require("../metrics");

const delay = 30;


async function getBitcoinPrice() {
  const response = await fetch('https://api.coindesk.com/v1/bpi/currentprice.json');
  const json = await response.json();
  const price = json.bpi.EUR.rate_float;
  metrics.bitcoinPriceMetric.set(price);
  setTimeout(getBitcoinPrice, delay * 1000);
}

async function getRandomUser() {
  const response = await fetch('https://randomuser.me/api/');
  const json = await response.json();
  const user = json.results[0];
  metrics.randomUserGauge.labels(user['gender'], user['dob']['age'].toString()).inc();
  setTimeout(getRandomUser, delay * 1000);
}


var router = express.Router();

debug("index.js loaded");


/* GET home page. */
router.get('/', function(req, res, next) {
  metrics.requestCounter.inc();
  res.render('index', { title: 'Express' });
});

// hello page
router.get("/hello", function(req, res, next) {
  debug("Hello World!");
  res.render('hello', {title: 'Hello World!'});
});


// a page intended to be slow 
router.get("/delayed", async function(req, res, next) {
  debug("Delayed response");
  //calcolo un delay casuale tra 0 e 1500 millisecondi
  let delay = Math.floor(Math.random() * 1500);
  //setTimeout fa in modo che la risposta venga inviata dopo i millisec specificati
  setTimeout(await function() {
    res.render('hello', {title: 'Delayed response'});
  }, delay);
});

// endpoint per le metriche
router.get("/metrics", async function(req, res, next) {
  res.set('Content-Type', promClient.register.contentType);
  res.send(await promClient.register.metrics());
});

router.get("/bitcoin", async function (req, res, next) {
  // get content from api, parse json, get price, expose it as metric and render it
  const response = await fetch('https://api.coindesk.com/v1/bpi/currentprice.json');
  const json = await response.json();
  const price = json.bpi.EUR.rate_float;
  metrics.bitcoinPriceMetric.set(price);
  res.render('public', { title: 'Bitcoin Price', data: price });
});

router.get('/randomuser', async function (req, res, next) {
  const response = await fetch('https://randomuser.me/api/');
  const json = await response.json();
  const user = json.results[0];
  randomUserGauge.labels(user['gender'], user['dob']['age'].toString()).inc();
  res.render('public', { title: 'Random User Age', data: JSON.stringify(user) });
});

router.get('/increase-cpu-load', (req, res) => {
  // Esegui un calcolo intensivo per 10 secondi
  const endTime = Date.now() + 10000; // 10 secondi
  while (Date.now() < endTime) {
    // Calcolo intensivo (es. operazioni matematiche pesanti)
    Math.random() * Math.random();
    const randomString = Math.random().toString();
    crypto.createHash('sha256').update(randomString).digest('hex');
  }

  res.send('Carico CPU aumentato per 10 secondi');
});

let leakedArray = [];
router.get('/memory-leak', (req, res) => {
  // doesn't really seem to do anything
  // add 100k elements to the array on each request
  leakedArray.push(new Array(100000).fill('leak'));

  res.send('Created memory leak. The array now has ' + leakedArray.length + ' elements in it.');
});

getBitcoinPrice()
getRandomUser()

module.exports = router;
