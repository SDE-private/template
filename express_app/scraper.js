const fetch = require('node-fetch');
const metrics = require("./metrics");

const getBitcoinPrice = async () => {
  const response = await fetch('https://api.coindesk.com/v1/bpi/currentprice.json');
  const json = await response.json();
  const price = json.bpi.EUR.rate_float;
  metrics.bitcoinPriceMetric.set(price);
  return price;
};

const getRandomUser = async () => {
  const response = await fetch('https://randomuser.me/api/');
  const json = await response.json();
  const user = json.results[0];
  metrics.randomUserGauge.labels(user['gender'], user['dob']['age'].toString()).inc();
  return user;
};

module.exports = {
  getBitcoinPrice,
  getRandomUser
}