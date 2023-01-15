module.exports = { connectBD, execSql, close }
const sql = require('mssql')
const fs = require('fs')
let cnn
let isConnected = false
async function connectBD(){
  let config = require('./config.json')

  // connect to db
  cnn = await sql.connect(config)
  isConnected = true
}

async function execSql(query, closeConnection, isLogs){
  let cnn
  if(!isConnected) await connectBD()

  try{
    // query
    let result = await sql.query(query)
  }catch (e){
    //Prevent error because the table Cidade does not have identity
    if(e.originalError.info.message != "'Cidade' does not contain an identity column."){
      console.log(e)
      process.exit(0)
    }

  }
  if(isLogs) console.log(result)
  // close connection
  //await cnn.close()
  if(closeConnection) await close()
}

async function close(){
  await cnn.close()
  process.exit(1)
}