const dotenv = require('dotenv');
const express = require('express');
const expressJSDocSwagger= require('express-jsdoc-swagger');
const server = express();

dotenv.config();
const SwaggerOptions = require('./services/SwaggerConfiguration');
const DataAccess = require('./services/DataAccess');
const RequestLogger = require('./middlewares/RequestLogger');

const AccountsController = require('./controllers/AccountsController');
const PlayerAccountController = require('./controllers/PlayerAccountController');
const UserTypeController = require('./controllers/UserTypeController');

expressJSDocSwagger(server)(SwaggerOptions);

server.use(RequestLogger);
server.use('/accounts',AccountsController);
server.use('/player',PlayerAccountController);
server.use('/usertype',UserTypeController);

server.listen(process.env.SERVER_PORT, () =>{
    console.log(`Server running at localhost, port: ${process.env.SERVER_PORT}`);
});