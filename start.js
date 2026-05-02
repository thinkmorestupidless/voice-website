// Ghost resolves relative paths from inside node_modules — set an absolute content path before it boots
process.env.paths__contentPath = require('path').resolve(__dirname, 'content');
require('ghost');
