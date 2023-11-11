const express = require('express');
const debug = require('debug')('express-app:server');
const promClient = require('prom-client');

const int_api_controller = require("../controllers/internal");
const ext_api_controller = require("../controllers/external")

const router = express.Router();

debug("index.js loaded");

// INTERNAL API
router.get('/', int_api_controller.home);
router.get("/hello", int_api_controller.hello);
router.get("/delayed", int_api_controller.delayed);
 
router.get('/increase-cpu-load', int_api_controller.cpu_burst);
router.get('/memory-leak', int_api_controller.memory_leak);

// BRIDGE API
router.get("/bitcoin", ext_api_controller.bitcoin);
router.get('/randomuser', ext_api_controller.random_user);

// endpoint per le metriche
router.get("/metrics", async (req, res) => {
  res.set('Content-Type', promClient.register.contentType);
  res.send(await promClient.register.metrics());
});

module.exports = router;
