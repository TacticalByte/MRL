const express = require('express');
const UserTypeController = express.Router();

 /**
 * GET /usertype/create
 * @summary Create a new user type, but you need to add using endpoint to grant/revoke access
 * @security BasicAuth
 * @tags UserType
 * @param {string} name.query.required - name param description
 * @return {object} 200 - success response - application/json
 * @return {object} 400 - Bad request response
 */
UserTypeController.get('/create',(req,res) => {
    res.json('New UserType created');
});

module.exports = UserTypeController;