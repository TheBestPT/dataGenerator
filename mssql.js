module.exports = { execSql }
const sql = require('mssql')
let cnn
let isConnected = false
async function connectBD(){
  let config = require('./config.json')

  // connect to db
  cnn = await sql.connect(config)
  isConnected = true
}

async function execSql(query, closeConnection){
  let cnn
  if(!isConnected) await connectBD()

  // query
  let result = await sql.query(query)
  console.log(result)
  // close connection
  //await cnn.close()
  if(closeConnection) await close()
}

async function close(){
  await cnn.close()
}