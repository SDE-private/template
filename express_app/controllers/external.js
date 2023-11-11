const scraper = require("../scraper");

const random_user = async (req, res) => {
  const user = await scraper.getRandomUser();
  res.render('public', { title: 'Random User Age', data: JSON.stringify(user) });
}

const bitcoin = async (req, res) => {
  const price = await scraper.getBitcoinPrice();
  res.render('public', { title: 'Bitcoin Price', data: price });
}

module.exports = {
  random_user,
  bitcoin
}