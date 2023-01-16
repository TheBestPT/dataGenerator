const fs = require('fs')
const genPassword = require('generate-password')
let mails = fs.readFileSync('./data/allEmailsDomains.txt').toString().split('\r\n')
let postal_code = require('../data/postal_code_city_country.json')
let names = fs.readFileSync('./data/names_clientes.txt').toString().split('\r\n')
const GENERO = ["feminino", "masculino", "outro"]
let creditCardNumbers = require('../data/paymentInformation.json')
let namesClient = fs.readFileSync('./data/names_clientes.txt').toString().split('\r\n')
const TIPO_PAGAMENTO = ['Visa', 'Mastercard', 'AmericanExpress', 'Discover']

module.exports = { gen }

function gen(){
    let clientes = []
    for(let i = 0; i < names.length; i++){
        let nome = names[i]
        //max age 120 year 
        let mes = randomIntFromInterval(1, 12)
        let dia
        let date = new Date()
        let ano = randomIntFromInterval(date.getFullYear()-120, date.getFullYear()-18)
        if(mes != 2 && mes <= 8) dia = (mes % 2 != 0) ? randomIntFromInterval(1, 31) : randomIntFromInterval(1, 30)
        else if (mes !=2)dia = (mes % 2 == 0) ? randomIntFromInterval(1, 31) : randomIntFromInterval(1, 30)
        else dia = leapyear(ano) ? randomIntFromInterval(1, 27) : randomIntFromInterval(1, 28)
        let dataNascimento = mes+"-"+dia+"-"+ano
        let nif = randomIntFromInterval(100000000, 999999999)
        let contato_telefonico = "+"+randomIntFromInterval(1, 998)+""+randomIntFromInterval(100000000, 999999999)
        let contato_emergencia = "+"+randomIntFromInterval(1, 998)+""+randomIntFromInterval(100000000, 999999999)            
        let email = names[i].replace(' ', '').toLowerCase().toString() + "@" + mails[randomIntFromInterval(0, mails.length - 1)]
        let password = genPassword.generate({
            length: 32,
            numbers: true,
            lowercase: true,
            uppercase: true
        })
        let postalCodeIndex = randomIntFromInterval(0, postal_code.length - 1)
        let codigo_postal_cidade = postal_code[postalCodeIndex].postalCode
        let codigo_postal_indicativo = postal_code[postalCodeIndex].postalCode
        let foto = "fotos/"+email+".jpg"
        let morada = postal_code[postalCodeIndex].long
        morada = morada.replaceAll("'", " ")
        let cidade = postal_code[postalCodeIndex].city
        let pais = postal_code[postalCodeIndex].country
        let genero = GENERO[randomIntFromInterval(0, GENERO.length - 1)]
        let data_ventimento =  randomIntFromInterval(1, 12)+'-'+randomIntFromInterval(new Date().getFullYear(), new Date().getFullYear()+6)
        let cvc_codigo = randomIntFromInterval(100, 999)
        let tipo_pagamento = TIPO_PAGAMENTO[randomIntFromInterval(0, TIPO_PAGAMENTO.length - 1)]
        let numero_cartao = creditCardNumbers[i].CreditCardNumber
        clientes.push({nome: nome, data_nascimento: dataNascimento, morada : morada, codigo_postal_indicativo : codigo_postal_indicativo, 
                        nif: nif, genero: genero, foto: foto, contato_telefonico: contato_telefonico, contato_emergencia: contato_emergencia,
                        email: email, password: password, cidade: cidade, pais : pais, data_vencimento: data_ventimento, cvc_codigo : cvc_codigo, tipo_pagamento: tipo_pagamento, numero_cartao: numero_cartao, nome_cartao: nome,
                        codigo_postal_cidade: codigo_postal_cidade})
    }
    return clientes
}

function leapyear(year){
    return (year % 100 === 0) ? (year % 400 === 0) : (year % 4 === 0);
}


function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min)
}


