const express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
const middlewares = require("./routes/middlewares");

var indexRouter = require('./routes/index');

const app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

// default middlewares
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use('/app', express.static('frontend'))

// custom middlewares
app.use(middlewares.store_request_info);
app.use(middlewares.four_0_four);
app.use(middlewares.errors_handler);

// routers
app.use('/', indexRouter);


module.exports = app;
