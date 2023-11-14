const express = require('express');
const path = require('path');
const logger = require('morgan');
const cors = require("cors");
const middlewares = require("./routes/middlewares");
const apiRouter = require('./routes/index');
const promClient = require('prom-client');
const app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

// default middlewares
app.use(cors());
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, 'public')));
app.use('/app', express.static('frontend'))


// store requests info middlewares
app.use(middlewares.store_request_info);

// routers
app.use('/api', apiRouter);

// endpoint per le metriche
app.get("/metrics", async (req, res) => {
  res.set('Content-Type', promClient.register.contentType);
  res.send(await promClient.register.metrics());
});

// 404 and errors middlewares
app.use(middlewares.four_0_four);
app.use(middlewares.errors_handler);

// define recurrent jobs
const scraper = require("./scraper");
setInterval(() => {
  scraper.getBitcoinPrice();
  scraper.getRandomUser();
}, 30 * 1000);

module.exports = app;
