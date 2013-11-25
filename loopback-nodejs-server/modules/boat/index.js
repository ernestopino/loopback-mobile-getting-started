/*!
 * A CRUD-capable model.
 */
var loopback = require('loopback');
var properties = require('./properties');
var config = require('./config');
var boat = loopback.Model.extend('boat', properties, config);

if (config['data-source']) {
  boat.attachTo(require('../' + config['data-source']));
}

module.exports = boat;
