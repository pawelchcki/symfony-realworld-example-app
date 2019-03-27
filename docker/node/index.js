//  /usr/local/lib/node_modules/newman/index.js + tracing

const tracer = require('dd-trace').init()
module.exports = require('./lib');
