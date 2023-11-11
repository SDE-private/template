const metrics = require("../metrics");

const random_user = async (req, res) => {
  const response = await fetch('https://randomuser.me/api/');
  const json = await response.json();
  const user = json.results[0];
  metrics.randomUserGauge.labels(user['gender'], user['dob']['age'].toString()).inc();
  res.render('public', { title: 'Random User Age', data: JSON.stringify(user) });
}

const bitcoin = async (req, res) => {
  // get content from api, parse json, get price, expose it as metric and render it
  const response = await fetch('https://api.coindesk.com/v1/bpi/currentprice.json');
  const json = await response.json();
  const price = json.bpi.EUR.rate_float;
  metrics.bitcoinPriceMetric.set(price);
  res.render('public', { title: 'Bitcoin Price', data: price });
}

module.exports = {
  random_user,
  bitcoin
}