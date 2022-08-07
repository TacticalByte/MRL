const swaggerDefinition = {
    info: {
      title: "Mech Royale League Website API",
      description: "This is the API for the website of MRL. For discord's bot, please refer to ..."
    },
    servers: ["http://localhost:8080"]
  }
  
  const swaggerJsDoc = require('swagger-jsdoc');
  const swaggerUi = require('swagger-ui-express');
  
  const swaggerOptions = {
    swaggerDefinition,
    apis: ["./controllers/*.js"]
  };
  
  const setup = server => server.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerJsDoc(swaggerOptions)));
  
  module.exports = setup;