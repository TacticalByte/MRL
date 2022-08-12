const dotenv = require('dotenv');
const express = require('express');
const expressJSDocSwagger= require('express-jsdoc-swagger');
const server = express();

dotenv.config();
const SwaggerOptions = require('./services/SwaggerConfiguration');
const RequestLogger = require('./middlewares/RequestLogger');

const AccountsController = require('./controllers/AccountsController');
const PlayerAccountController = require('./controllers/PlayerAccountController');
const UserTypeController = require('./controllers/UserTypeController');
const MembershipController = require('./controllers/MembershipsController');

expressJSDocSwagger(server)(SwaggerOptions.options);

server.use(express.json());
server.use(RequestLogger);
server.use('/accounts',AccountsController);
server.use('/playeraccount',PlayerAccountController);
server.use('/usertype',UserTypeController);
server.use('/membership',MembershipController);

server.listen(process.env.SERVER_PORT, () =>{
    console.log(`Server running at localhost, port: ${process.env.SERVER_PORT}`);
});