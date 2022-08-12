const express = require('express');
const db = require('../services/DataAccess');
const MembershipsController = express.Router();

/**
 * CreateMembershipController request object
 * @typedef {object} CreateMembershipRequest
 * @property {string} MembershipName.required - CreateMembership MembershipName
 * @property {string} Price.required - CreateMembership Price
 * @property {string} Discount.required - CreateMembership Discount
 * @property {string} Status.required - CreateMembership Status
 * @property {string} CreationDate.required - CreatedMembership CreationDate
 * * @property {string} CreatedBy.required - CreatedMembership CreatedBy
 */

/**
 * POST /Membership/Create
 * @summary Create a new Membership header plan for MRL
 * @security BasicAuth
 * @tags Memberships
 * @param {CreateMembershipRequest} request.body.required - Created Membership
 * @return {object} 200 - success response - application/json
 * @return {object} 400 - Bad request response
 */
MembershipsController.post('/create', async(req,res) =>{
    try {
        let params = {
            MembershipName: req.body.Name ? req.body.Name : null,
            Price: req.body.Price ? req.body.Price : null,
            Discount: req.body.Discount ? req.body.Discount : null,
            Status: req.body.Status ? req.body.Status : null,
            CreationDate: req.body.CreationDate ? req.body.CreationDate : null,
            CreatedBy: req.body.CreatedBy ? req.body.CreatedBy : null
        }
        const result =  await db.ExecuteStoredProcedure('BAD.SP_CREATE_MEMBERSHIP',params);
        res.status(200).send(result);
    
    } catch (error) {
        console.error(`/membership/create Error: ${error}`);
        res.status(500).send(error);
    }
});

module.exports = MembershipsController;