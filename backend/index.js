const dotenv = require('dotenv');
const express = require('express');
const expressJSDocSwagger= require('express-jsdoc-swagger');
const server = express();

dotenv.config();

const RequestLogger = require('./middlewares/RequestLogger');
const AccountsController = require('./controllers/AccountsController');
const PlayerAccountController = require('./controllers/PlayerAccountController');
const UserTypeController = require('./controllers/UserTypeController');

const DataAccess = require('./services/DataAccess');

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
    filesPattern: './controllers/*.js',
  };

expressJSDocSwagger(server)(options);

server.use(RequestLogger);

server.use('/accounts',AccountsController);
server.use('/player',PlayerAccountController);
server.use('/usertype',UserTypeController);

server.get('/', (req,res) =>{
  let params = {
    Property1: 1,
    Property2: 2
  }
  DataAccess.ExecuteStoredProcedure('BAD.SP_GET_ACCOUNT',{Email: 'mmbarrerae@gmail.com'});
  // DataAccess.GetAccounts();
  res.send('executed!');
})

server.listen(process.env.SERVER_PORT, () =>{
    console.log(`Server running at localhost, port: ${process.env.SERVER_PORT}`);
});