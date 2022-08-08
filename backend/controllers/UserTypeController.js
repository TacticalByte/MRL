const express = require('express');
const db = require('../services/DataAccess');
const UserTypeController = express.Router();

/**
 * UserType request object
 * @typedef {object} UserTypeRequest
 * @property {string} UserType.required - UserType Name
 * @property {DateTime} CreationDate.optional - UserType CreationDate
 * @property {string} CreatedBy.optional - UserType CreatedBy
 */

/**
 * Update - UserType request object
 * @typedef {object} UpdateUserTypeRequest
 * @property {string} UserTypeID.required - UserType UserTypeID (Valid for Update/Deletion only)
 * @property {string} UserType.required - UserType Name
 * @property {DateTime} ModificationDate.optional -  UserType Modification
 * @property {string} ModifiedBy.optional - UserType ModifiedBy
 */

 /**
 * POST /usertype/create
 * @summary Create a new UserType for MRL website accounts 
 * @security BasicAuth
 * @tags UserType
 * @param {UserTypeRequest} request.body.required - UserType Info
 * @return {object} 200 - success response - application/json
 * @return {object} 400 - Bad request response
 */
UserTypeController.post('/create',async (req,res) => {
    try {
        let params = {
            UserType: req.body.UserType ? req.body.UserType : null,
            CreationDate: req.body.CreationDate ? req.body.CreationDate : null,
            CreatedBy: req.body.CreatedBy ? req.body.CreatedBy : null
        }
        const result =  await db.ExecuteStoredProcedure('BAD.SP_CREATE_USERTYPE',params);
        res.status(200).send(result);

    } catch (error) {
        console.error(`/usertype/Create Error: ${error}`);
        res.status(500).send(error);
    }
});

 /**
 * PUT /usertype/update
 * @summary Totally update an existent UserType for MRL website accounts 
 * @security BasicAuth
 * @tags UserType
 * @param {UpdateUserTypeRequest} request.body.required - Update UserType Info
 * @return {object} 200 - success response - application/json
 * @return {object} 400 - Bad request response
 */
UserTypeController.put('/update',async (req,res) => {
    try {
        let params = {
            UserTypeID: req.body.UserTypeID ? req.body.UserTypeID : null,
            UserType: req.body.UserType ? req.body.UserType : null,
            ModificationDate: req.body.ModificationDate ? req.body.ModificationDate : null,
            ModifiedBy: req.body.ModifiedBy ? req.body.ModifiedBy : null
        }

    const result =  await db.ExecuteStoredProcedure('BAD.SP_UPDATE_USERTYPE',params);
    res.status(200).send(result);

    } catch (error) {
        console.error(`/usertype/update Error: ${error}`);
        res.status(500).send(error);
    }
});

module.exports = UserTypeController;