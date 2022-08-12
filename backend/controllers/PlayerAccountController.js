const express = require('express');
const db = require('../services/DataAccess');
const PlayerAccountController = express.Router();

/**
 * CreatePlayerAccountRequest request object
 * @typedef {object} CreatePlayerAccountRequest
 * @property {string} AccountID.required - PlayerAccount AccountID
 * @property {string} SMCID.required - PlayerAccount SMCID
 * @property {string} Picture.required - PlayerAccount Picture
 * @property {string} Status.required - PlayerAccount Status
 * @property {string} SMCRank.required - PlayerAccount SMCRank
 * @property {string} Divition.required - PlayerAccount Divition
 * @property {string} MainMecha1.required - PlayerAccount MainMecha1
 * @property {string} MainMecha2.required - PlayerAccount MainMecha2
 * @property {string} MainMecha3.required - PlayerAccount MainMecha3
 * @property {string} MainPilot.required - PlayerAccount MainPilot
 * @property {string} ClanID.required - PlayerAccount ClanID
 * @property {string} ClanTitle.required - PlayerAccount ClanTitle
 * @property {string} RMLFamePoints.required - PlayerAccount RMLFamePoints
 * @property {string} RMLPassActive.required - PlayerAccount RMLPassActive
 * @property {string} RMLTitle.required - PlayerAccount RMLTitle
 * @property {string} CreationDate.required - PlayerAccount CreationDate
 * @property {string} CreatedBy.required - PlayerAccount CreatedBy
 */
;
/**
 * UpdatePlayerAccountRequest request object
 * @typedef {object} UpdatePlayerAccountRequest
 * @property {string} PlayerAccountID.required - PlayerAccount PlayerAccountID
 * @property {string} AccountID.required - PlayerAccount AccountID
 * @property {string} SMCID.required - PlayerAccount SMCID
 * @property {string} Picture.required - PlayerAccount Picture
 * @property {string} Status.required - PlayerAccount Status
 * @property {string} SMCRank.required - PlayerAccount SMCRank
 * @property {string} Divition.required - PlayerAccount Divition
 * @property {string} MainMecha1.required - PlayerAccount MainMecha1
 * @property {string} MainMecha2.required - PlayerAccount MainMecha2
 * @property {string} MainMecha3.required - PlayerAccount MainMecha3
 * @property {string} MainPilot.required - PlayerAccount MainPilot
 * @property {string} ClanID.required - PlayerAccount ClanID
 * @property {string} ClanTitle.required - PlayerAccount ClanTitle
 * @property {string} RMLFamePoints.required - PlayerAccount RMLFamePoints
 * @property {string} RMLPassActive.required - PlayerAccount RMLPassActive
 * @property {string} RMLTitle.required - PlayerAccount RMLTitle
 * @property {DateTime} ModificationDate.required - PlayerAccount ModificationDate
 * @property {DateTime} ModifiedBy.required - PlayerAccount ModifiedBy
 */

/**
 * DeletePlayerAccountRequest request object
 * @typedef {object} DeletePlayerAccountRequest
 * @property {string} PlayerAccountID.required - PlayerAccount PlayerAccountID
 * @property {DateTime} ModificationDate.required - PlayerAccount ModificationDate
 * @property {DateTime} ModifiedBy.required - PlayerAccount ModifiedBy
 */

/**
 * POST /PlayerAccount/Create
 * @summary Craete a new player account (Mobile or Steam)
 * @security BasicAuth
 * @tags PlayerAccount
 * @param {CreatePlayerAccountRequest} request.body.required - Create PlayerAccount info
 * @return {object} 200 - success response - application/json
 * @return {object} 400 - Bad request response
 */
PlayerAccountController.post('/create', async (req,res)=>{
    try {
        let params = {
            AccountID: req.body.AccountID ? req.body.AccountID : null,
            SMCID: req.body.SMCID ? req.body.SMCID : null,
            Picture: req.body.Picture ? req.body.Picture : null,
            Status: req.body.Status ? req.body.Status : null,
            SMCRank: req.body.SMCRank ? req.body.SMCRank : null,
            Divition: req.body.Divition ? req.body.Divition : null,
            MainMecha1: req.body.MainMecha1 ? req.body.MainMecha1 : null,
            MainMecha2: req.body.MainMecha2 ? req.body.MainMecha2 : null,
            MainMecha3: req.body.MainMecha3 ? req.body.MainMecha3 : null,
            MainPilot: req.body.MainPilot ? req.body.MainPilot : null,
            ClanID: req.body.ClanID ? req.body.ClanID : null,
            ClanTitle: req.body.ClanTitle ? req.body.ClanTitle : null,
            RMLFamePoints: req.body.RMLFamePoints ? req.body.RMLFamePoints : null,
            RMLPassActive: req.body.RMLPassActive ? req.body.RMLPassActive : null,
            RMLTitle: req.body.RMLTitle ? req.body.RMLTitle : null,
            CreationDate: req.body.CreationDate ? req.body.CreationDate : null,
            CreatedBy: req.body.CreatedBy ? req.body.CreatedBy : null
        }
        const result =  await db.ExecuteStoredProcedure('BAD.SP_CREATE_PLAYER_ACCOUNT',params);
        res.status(200).send(result);
    
    } catch (error) {
        console.error(`/playeraccount/create Error: ${error}`);
        res.status(500).send(error);
    }
});

/**
 * PUT /PlayerAccount/Update
 * @summary Totally update a player account (Mobile or Steam)
 * @security BasicAuth
 * @tags PlayerAccount
 * @param {UpdatePlayerAccountRequest} request.body.required - Create PlayerAccount info
 * @return {object} 200 - success response - application/json
 * @return {object} 400 - Bad request response
 */
PlayerAccountController.put('/update', async(req,res) => {
  try {
    let params = {
        PlayerAccountID: req.body.PlayerAccountID ? req.body.PlayerAccountID : null,
        AccountID: req.body.AccountID ? req.body.AccountID : null,
        SMCID: req.body.SMCID ? req.body.SMCID : null,
        Picture: req.body.Picture ? req.body.Picture : null,
        Status: req.body.Status ? req.body.Status : null,
        SMCRank: req.body.SMCRank ? req.body.SMCRank : null,
        Divition: req.body.Divition ? req.body.Divition : null,
        MainMecha1: req.body.MainMecha1 ? req.body.MainMecha1 : null,
        MainMecha2: req.body.MainMecha2 ? req.body.MainMecha2 : null,
        MainMecha3: req.body.MainMecha3 ? req.body.MainMecha3 : null,
        MainPilot: req.body.MainPilot ? req.body.MainPilot : null,
        ClanID: req.body.ClanID ? req.body.ClanID : null,
        ClanTitle: req.body.ClanTitle ? req.body.ClanTitle : null,
        RMLFamePoints: req.body.RMLFamePoints ? req.body.RMLFamePoints : null,
        RMLPassActive: req.body.RMLPassActive ? req.body.RMLPassActive : null,
        RMLTitle: req.body.RMLTitle ? req.body.RMLTitle : null,
        ModificationDate: req.body.ModificationDate ? req.body.ModificationDate : null,
        ModifiedBy: req.body.ModifiedBy ? req.body.ModifiedBy : null,
        }

    const result =  await db.ExecuteStoredProcedure('BAD.SP_UPDATE_PLAYER_ACCOUNT',params);
    res.status(200).send(result);

} catch (error) {
    console.error(`/playeraccount/update Error: ${error}`);
    res.status(500).send(error);
}
});

/**
 * DELETE /PlayerAccount/Delete
 * @summary Delete a player account (Mobile or Steam)
 * @security BasicAuth
 * @tags PlayerAccount
 * @param {DeletePlayerAccountRequest} request.body.required - Create PlayerAccount info
 * @return {object} 200 - success response - application/json
 * @return {object} 400 - Bad request response
 */
PlayerAccountController.delete('/delete', async(req,res) => {
    try {
        let params = {
            PlayerAccountID: req.body.PlayerAccountID ? req.body.PlayerAccountID : null,
            ModificationDate: req.body.ModificationDate ? req.body.ModificationDate : null,
            ModifiedBy: req.body.ModifiedBy ? req.body.ModifiedBy : null
            }
    
        const result =  await db.ExecuteStoredProcedure('BAD.SP_DELETE_PLAYER_ACCOUNT',params);
        res.status(200).send(result);
    
    } catch (error) {
        console.error(`/playeraccount/delete Error: ${error}`);
        res.status(500).send(error);
    }
});

module.exports = PlayerAccountController;