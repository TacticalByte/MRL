const express = require('express');
const db = require('../services/DataAccess');
const AccountsController = express.Router();

/**
 * CreateAccount request object
 * @typedef {object} CreateAccount
 * @property {string} FirstName.required - CreateAccount FirstName
 * @property {string} LastName.required - CreateAccount LastName
 * @property {string} BirthDate.required - CreateAccount BirthDate
 * @property {string} Email.required - CreateAccount Email
 * @property {string} Password.required - CreateAccount Password
 * @property {string} FacebookAccount.required - CreateAccount FacebookAccount
 * @property {string} TwitterAccount.required - CreateAccount Status
 * @property {string} DiscordAccount.required - CreateAccount Status
 * @property {string} YoutubeAccount.required - CreateAccount Status
 * @property {string} SteamAccount.required - CreateAccount Status
 * @property {string} Status.required - CreateAccount Status
 * @property {string} IsValidated.required - CreateAccount Status
 * @property {string} UserType.required - CreateAccount Status
 * @property {string} MembershipID.required - CreateAccount Status
 * @property {string} CreationDate.required - CreateAccount CreationDate
 * @property {string} CreatedBy.required - CreateAccount CreatedBy
 */

/**
 * UpdateAccount request object
 * @typedef {object} UpdateAccount
 * @property {string} AccountID.required - UpdateAccount AccountID
 * @property {string} FirstName.required - UpdateAccount FirstName
 * @property {string} LastName.required - UpdateAccount LastName
 * @property {string} BirthDate.required - UpdateAccount BirthDate
 * @property {string} Email.required - UpdateAccount Email
 * @property {string} Password.required - UpdateAccount Password
 * @property {string} FacebookAccount.required - UpdateAccount FacebookAccount
 * @property {string} TwitterAccount.required - UpdateAccount TwitterAccount
 * @property {string} DiscordAccount.required - UpdateAccount DiscordAccount
 * @property {string} YoutubeAccount.required - UpdateAccount YoutubeAccount
 * @property {string} SteamAccount.required - UpdateAccount SteamAccount
 * @property {string} Status.required - UpdateAccount Status
 * @property {string} IsValidated.required - UpdateAccount IsValidated
 * @property {string} UserType.required - UpdateAccount UserType
 * @property {string} MembershipID.required - UpdateAccount MembershipID
 * @property {string} ModificationDate.required - UpdateAccount ModificationDate
 * @property {string} ModifiedBy.required - UpdateAccount ModifiedBy
 */

/**
 * DeleteAccount request object
 * @typedef {object} DeleteAccount
 * @property {string} AccountID.required - DeleteAccount AccountID
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

/**
 * PUT /Accounts/Update
 * @summary Totally update a new website account
 * @security BasicAuth
 * @tags Accounts
 * @param {UpdateAccount} request.body.required - name param description
 * @return {object} 200 - success response - application/json
 * @return {object} 400 - Bad request response
 */
AccountsController.put('/update', async(req,res) => {
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
    const result =  await db.ExecuteStoredProcedure('BAD.SP_CREATE_ACCOUNT',params);
    res.status(200).send(result);

} catch (error) {
    console.error(`/playeraccount/update Error: ${error}`);
    res.status(500).send(error);
}
})

module.exports = AccountsController;