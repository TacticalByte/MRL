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
        encrypt: false, // for azure
        trustServerCertificate: true // change to true for local dev / self-signed certs
      }
  }

const GetAccounts = async () => {
    try{
        let pool = await db.connect(sqlConfig);
        let result = await pool.request()
        .query('SELECT * FROM BAD.ACCOUNTS');

    console.log(result);
    }
    catch(err){
        console.error(`ERROR IN DataAccess: ${err}`);
    }
}

module.exports = {GetAccounts}