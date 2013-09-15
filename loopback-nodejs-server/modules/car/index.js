/*!
 * A CRUD-capable model.
 */
var loopback = require('loopback');
var properties = require('./properties');
var config = require('./config');
var car = loopback.createModel('car', properties, config);
var applications = config.applications || [];

if (config['data-source']) {
  car.attachTo(require('../' + config['data-source']));
}

applications.forEach(function (name) {
  var app = require('../' + name);
  app.model(car);
});

module.exports = car;
