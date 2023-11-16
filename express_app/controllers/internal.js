const crypto = require('crypto');
const metrics = require("../metrics");
const debug = require('debug')('express-app:server');

const delay = 30;


const home = (req, res) => {
  metrics.requestCounter.inc();
  res.render('index', { title: 'Express' });
};

const hello = (req, res) => {
  debug("Hello World!");
  res.render('hello', {title: 'Hello World!'});
};

const delayed = async (req, res) => {
  debug("Delayed response");
  //calcolo un delay casuale tra 0 e 1500 millisecondi
  let delay = Math.floor(Math.random() * 1500);
  //setTimeout fa in modo che la risposta venga inviata dopo i millisec specificati
  setTimeout(await function() {
    res.render('hello', {title: 'Delayed response'});
  }, delay);
};

const cpu_burst = (req, res) => {
  const to_hash = req.query.string || "random_string";
  console.log(to_hash);
  crypto.pbkdf2('secret', 'salt', 10e6, 512, 'sha512', (err, dk) => {
    res.send({});
  });
};


let leakedArray = [];
const memory_leak = (req, res) => {
  // doesn't really seem to do anything
  // add 100k elements to the array on each request
  leakedArray.push(new Array(10e6).fill('leak'));
  res.send({});
};


module.exports = {
  home,
  hello,
  delayed,
  cpu_burst,
  memory_leak
}