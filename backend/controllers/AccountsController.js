const express = require('express');
const db = require('../services/DataAccess');
const AccountsController = express.Router();

/**
 * CreateAccount request object
 * @typedef {object} CreateAccount
 * @property {string} FirstName.required - PlayerAccount AccountID
 * @property {string} LastName.required - PlayerAccount SMCID
 * @property {string} BirthDate.required - PlayerAccount Picture
 * @property {string} Email.required - PlayerAccount Status
 * @property {string} Password.required - PlayerAccount Status
 * @property {string} FacebookAccount.required - PlayerAccount Status
 * @property {string} TwitterAccount.required - PlayerAccount Status
 * @property {string} DiscordAccount.required - PlayerAccount Status
 * @property {string} YoutubeAccount.required - PlayerAccount Status
 * @property {string} SteamAccount.required - PlayerAccount Status
 * @property {string} Status.required - PlayerAccount Status
 * @property {string} IsValidated.required - PlayerAccount Status
 * @property {string} UserType.required - PlayerAccount Status
 * @property {string} MembershipID.required - PlayerAccount Status
 * @property {string} CreationDate.required - PlayerAccount CreationDate
 * @property {string} CreatedBy.required - PlayerAccount CreatedBy
 */

  /**
 * POST /Accounts/Create
 * @summary Create a new website account
 * @security BasicAuth
 * @tags Accounts
 * @param {CreateAccount} request.body.required - name param description
 * @return {object} 200 - success response - application/json
 * @return {object} 400 - Bad request response
 */
AccountsController.post('/create', async(req,res) => {
  try {
    let params = {
        FirstName: req.body.FirstName ? req.body.FirstName : null,
        LastName: req.body.LastName ? req.body.LastName : null,
        BirthDate: req.body.BirthDate ? req.body.BirthDate : null,
        Email: req.body.Email ? req.body.Email : null,
        Password: req.body.Password ? req.body.Password : null,
        FacebookAccount: req.body.FacebookAccount ? req.body.FacebookAccount : null,
        TwitterAccount: req.body.TwitterAccount ? req.body.TwitterAccount : null,
        DiscordAccount: req.body.DiscordAccount ? req.body.DiscordAccount : null,
        YoutubeAccount: req.body.YoutubeAccount ? req.body.YoutubeAccount : null,
        SteamAccount: req.body.SteamAccount ? req.body.SteamAccount : null,
        Status: req.body.Status ? req.body.Status : null,
        IsValidated: req.body.IsValidated ? req.body.IsValidated : null,
        UserTypeID: req.body.UserTypeID ? req.body.UserTypeID : null,
        MembershipID: req.body.MembershipID ? req.body.MembershipID : null,
        CreationDate: req.body.CreationDate ? req.body.CreationDate : null,
        CreatedBy: req.body.CreatedBy ? req.body.CreatedBy : null
    }
    const result =  await db.ExecuteStoredProcedure('BAD.SP_CREATE_NEW_ACCOUNT',params);
    res.status(200).send(result);

} catch (error) {
    console.error(`/playeraccount/create Error: ${error}`);
    res.status(500).send(error);
}
})

module.exports = AccountsController;