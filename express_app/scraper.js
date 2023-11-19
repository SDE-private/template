const fetch = require('node-fetch');
const metrics = require("./metrics");
const { use } = require('./routes');

let firstRun = true;

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
  const gender = user['gender'];
  const range = getAgeRange(parseInt(user['dob']['age']));
  metrics.randomUserGender.labels({ gender }).inc();
  if (firstRun) initAgeRanges();
  metrics.randomUserAge.observe({ range }, 1);
  firstRun = false;
  return user;
};

function initAgeRanges() {
  // set the initial values for the age ranges to 0
  for (let i = 0; i < 10; i++) {
    const range = `${i * 10}-${(i * 10) + 9}`;
    metrics.randomUserAge.observe({ range }, 0);
  }
}

function getAgeRange(age) {
  const bucketIndex = Math.floor(age / 10);
  const startValue = bucketIndex * 10;
  const endValue = startValue + 9;
  return `${startValue}-${endValue}`;
} 

module.exports = {
  getBitcoinPrice,
  getRandomUser
}