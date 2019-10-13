const { environment } = require('@rails/webpacker')
const customConfig = require('./custom.js');
environment.config.merge(customConfig);
module.exports = environment;

