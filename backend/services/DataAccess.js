const { request } = require('express');
const db = require('mssql');

const sqlConfig = {
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
    server: process.env.DB_SERVER,
    pool: {
      max: 10,
      min: 0,
      idleTimeoutMillis: 30000
    },
    options: {
        encrypt: false,
        trustServerCertificate: true // change to true for local dev / self-signed certs
      }
  }

const ExecuteStoredProcedure = async(spName, params) => {
    try{
        let pool = await db.connect(sqlConfig);
        let request = await pool.request();

        for (const key of Object.keys(params)) {
            request.input(key,params[key]);
        }
        const response = await request.execute(spName);
        console.log(response);
    }
    catch(err){
        console.error(`ERROR IN ExecuteStoredProcedure: ${err}`);
    }
};

module.exports = {GetAccounts,ExecuteStoredProcedure}