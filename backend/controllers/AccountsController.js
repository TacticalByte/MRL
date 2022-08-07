const express = require('express');
const AccountsController = express.Router();


  /**
 * GET /Accounts/Create
 * @summary Create a new website account
 * @security BasicAuth
 * @tags Accounts
 * @param {string} name.query.required - name param description
 * @return {object} 200 - success response - application/json
 * @return {object} 400 - Bad request response
 */
AccountsController.get('/create', (req,res) => {
    res.json("New account created!");
})

module.exports = AccountsController;