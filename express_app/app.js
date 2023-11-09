var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var promClient = require('prom-client');  // Importa prom-client

// Crea un istanza di un istogramma per registrare la durata delle richieste HTTP
const responseTimeMetric = new promClient.Histogram({
  name: 'http_request_duration_seconds',
  help: 'Duration of HTTP requests in seconds',
  labelNames: ['method', 'path', 'response_code'],
});

var indexRouter = require('./routes/index');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// Usa il middleware per registrare le metriche per ogni richiesta
// Questo è un middleware Express.js che viene eseguito per ogni richiesta HTTP ricevuta dal tuo server
app.use((req, res, next) => {
  const end = responseTimeMetric.startTimer();
  res.on('finish', () => {
    end({ method: req.method, path: req.path, response_code: res.statusCode });
  });
  next();
});
app.use('/', indexRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error', {title: err.message, error: err});
});

module.exports = app;
