const options = {
    info: {
      version: '1.0.0',
      title: 'MRL Website API',
      description: 'Base MRL Website API.',
      license: {
        name: 'MIT',
      },
    },
    security: {
      BasicAuth: {
        type: 'http',
        scheme: 'basic',
      },
    },
    baseDir: __dirname,
    filesPattern: '../controllers/*.js',
  };

  module.exports = {options};