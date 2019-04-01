//  /usr/local/lib/node_modules/newman/index.js + tracing

require('dd-trace').init();
module.exports = require('./lib');
