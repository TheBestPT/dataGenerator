const fs = require('fs')
const genPassword = require('generate-password')
let names = fs.readFileSync('./data/adminNames.txt').toString().split('\r\n')
let mails = fs.readFileSync('./data/allEmailsDomains.txt').toString().split('\r\n')
const GENERO = ["feminino", "masculino", "outro"]
module.exports = { gen }

function gen(){
    let clientes = []
    for(let i = 0; i < names.length; i++){
        let nome = names[i]
        //max age 120 year 
        let mes = randomIntFromInterval(1, 12)
        let dia
        if(mes != 2 && mes <= 8) dia = (mes % 2 != 0) ? randomIntFromInterval(1, 31) : randomIntFromInterval(1, 30)
        else if (mes !=2)dia = (mes % 2 == 0) ? randomIntFromInterval(1, 31) : randomIntFromInterval(1, 30)
        else dia = randomIntFromInterval(1, 28)
        let date = new Date()
        let ano = randomIntFromInterval(date.getFullYear()-120, date.getFullYear()-18)
        let dataNascimento = mes+"-"+dia+"-"+ano
        let contato_telefonico = "+"+randomIntFromInterval(1, 998)+""+randomIntFromInterval(100000000, 999999999)            
        let email = names[i].replace(' ', '').toLowerCase().toString() + "@" + mails[randomIntFromInterval(0, mails.length - 1)]
        let password = genPassword.generate({
            length: 32,
            numbers: true,
            lowercase: true,
            uppercase: true
        })
        clientes.push({nome: nome, data_nascimento: dataNascimento, genero: GENERO[randomIntFromInterval(0, GENERO.length - 1)], contato_telefonico: contato_telefonico, email: email, password: password})
    }
    return clientes
}


function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min)
}


