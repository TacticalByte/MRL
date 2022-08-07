const express = require('express');
const PlayerAccountController = express.Router();

  /**
 * GET /PlayerAccount/Create
 * @summary Craete a new player account (Mobile or Steam)
 * @security BasicAuth
 * @tags PlayerAccount
 * @param {string} name.query.required - name param description
 * @return {object} 200 - success response - application/json
 * @return {object} 400 - Bad request response
 */
PlayerAccountController.get('/Create',(req,res)=>{
    res.json('Player Account Created!');
});

module.exports = PlayerAccountController;