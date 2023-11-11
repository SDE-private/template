const crypto = require('crypto');
const metrics = require("../metrics");

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
  // Esegui un calcolo intensivo per 10 secondi
  const endTime = Date.now() + 10000; // 10 secondi
  while (Date.now() < endTime) {
    // Calcolo intensivo (es. operazioni matematiche pesanti)
    Math.random() * Math.random();
    const randomString = Math.random().toString();
    crypto.createHash('sha256').update(randomString).digest('hex');
  }

  res.send('Carico CPU aumentato per 10 secondi');
};


let leakedArray = [];
const memory_leak = (req, res) => {
  // doesn't really seem to do anything
  // add 100k elements to the array on each request
  leakedArray.push(new Array(100000).fill('leak'));

  res.send('Created memory leak. The array now has ' + leakedArray.length + ' elements in it.');
};


module.exports = {
  home,
  hello,
  delayed,
  cpu_burst,
  memory_leak
}