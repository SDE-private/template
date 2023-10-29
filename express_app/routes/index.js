var express = require('express');
var debug = require('debug')('express-app:server');
var promClient = require('prom-client');

const requestCounter = new promClient.Counter({
  name: 'homepage_request_counter',
  help: 'Total number of requests on the homepage',
});


var router = express.Router();

debug("index.js loaded");


/* GET home page. */
router.get('/', function(req, res, next) {
  requestCounter.inc();
  const locals = { title: 'Express' };
  res.render('index', locals);
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

module.exports = router;
