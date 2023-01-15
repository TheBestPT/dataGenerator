const fs = require('fs')
const genPassword = require('generate-password')
let mails = fs.readFileSync('./data/allEmailsDomains.txt').toString().split('\r\n')
let postal_code = require('../data/zipcodes.pt.json')
const GENERO = ["feminino", "masculino", "outro"]

module.exports = { gen }

function gen(isClient = false){
    let names = fs.readFileSync((isClient) ? './data/names_clientes.txt' : './data/names_afintriao.txt').toString().split('\r\n')
    let afintrioes = []
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
        let contato_emergencia = "+"+randomIntFromInterval(1, 998)+""+randomIntFromInterval(100000000, 999999999)    
        let superhost = false
        let email = names[i].replace(' ', '').toLowerCase().toString() + "@" + mails[randomIntFromInterval(0, mails.length - 1)]
        let password = genPassword.generate({
            length: 32,
            numbers: true,
            lowercase: true,
            uppercase: true
        })
        let postalCodeIndex = randomIntFromInterval(0, postal_code.length - 1)
        let codigo_postal_cidade = postal_code[postalCodeIndex].zipcode.substring(0, 4)
        let codigo_postal_indicativo = postal_code[postalCodeIndex].zipcode.substring(5)
        let foto = "fotos/"+email+".jpg"
        let morada = postal_code[postalCodeIndex].place
        morada = morada.replaceAll("'", " ")
        let cidade = postal_code[postalCodeIndex].state
        let pais = "Portugal"
        let genero = GENERO[randomIntFromInterval(0, GENERO.length - 1)]
        afintrioes.push({nome: nome, data_nascimento: dataNascimento, morada : morada, codigo_postal_indicativo : codigo_postal_indicativo, 
                        genero: genero, foto: foto, contato_telefonico: contato_telefonico, contato_emergencia: contato_emergencia,
                        superhost: superhost, email: email, password: password, cidade: cidade, pais : pais,
                        codigo_postal_cidade: codigo_postal_cidade})
    }
    return afintrioes
}


function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min)
}


