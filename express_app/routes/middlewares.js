const metrics = require("../metrics");
const createError = require('http-errors');

// Usa il middleware per registrare le metriche per ogni richiesta
// Questo è un middleware Express.js che viene eseguito per ogni richiesta HTTP ricevuta dal tuo server
const store_request_info = (req, res, next) => {
  const end = metrics.responseTimeMetric.startTimer();
  res.on('finish', () => {
    end({ method: req.method, path: req.path, response_code: res.statusCode });
  });
  next();
};

// error handler
const errors_handler = (err, req, res, next) => {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error', {title: err.message, error: err});
}

// catch 404 and forward to error handler
const four_0_four = (req, res, next) => {
  next(createError(404));
};

module.exports = {
  store_request_info,
  errors_handler,
  four_0_four
}