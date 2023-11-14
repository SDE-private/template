const express = require('express');
const path = require('path');
const logger = require('morgan');
const cors = require("cors");
const middlewares = require("./routes/middlewares");
const indexRouter = require('./routes/index');
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
app.use('/api', indexRouter);

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
