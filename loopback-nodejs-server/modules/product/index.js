/*!
 * A CRUD-capable model.
 */
var loopback = require('loopback');
var properties = require('./properties');
var config = require('./config');
var product = loopback.Model.extend('product', properties, config);

if (config['data-source']) {
  product.attachTo(require('../' + config['data-source']));
}

module.exports = product;
