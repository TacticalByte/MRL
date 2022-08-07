const express = require('express');
const db = require('../services/DataAccess');
const UserTypeController = express.Router();

/**
 * UserType request object
 * @typedef {object} UserTypeRequest
 * @property {string} UserType.required - UserType Name
 * @property {string} CreationDate.optional - UserType CreationDate
 * @property {string} CreatedBy.optional- UserType CreatedBy
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
UserTypeController.post('/create',(req,res) => {
    try {
        let params = {
            UserType: req.body.UserType ? req.body.UserType.trim() : null,
            CreationDate: req.body.CreationDate ? req.body.CreationDate.trim() : null,
            CreatedBy: req.body.CreatedBy ? req.body.CreatedBy.trim() : null
        }

    console.log(JSON.stringify(params));

    const result = db.ExecuteStoredProcedure('BAD.SP_CREATE_USERTYPE',params);
    console.log(`Esta es la respuesta: ${JSON.stringify(result)}`);
    } catch (error) {
        console.error(`/UserType/Create Error: ${error}`);
    }
    res.json('New UserType created');
});

module.exports = UserTypeController;