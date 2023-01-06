const fs = require('fs')
let creditCardNumbers = require('../data/paymentInformation.json')
let namesClient = fs.readFileSync('./data/names_clientes.txt').toString().split('\r\n')
const TIPO_PAGAMENTO = ['Visa', 'Mastercard', 'AmericanExpress', 'Discover']

module.exports = { gen }

function gen(){
    tipo_pagamento = []
    for(let i = 0; i < creditCardNumbers.length; i++){
        let indexClient = randomIntFromInterval(0, 1000)
        let month = randomIntFromInterval(new Date().getMonth(), 12)
        let year = randomIntFromInterval(new Date().getFullYear(), new Date().getFullYear()+6)
        tipo_pagamento.push({tipo_pagamento: TIPO_PAGAMENTO[randomIntFromInterval(0, TIPO_PAGAMENTO.length - 1)],nome_cartao: namesClient[indexClient], 
            numero_cartao: creditCardNumbers[i].CreditCardNumber, 
            cvc_codigo: randomIntFromInterval(0, 999), data_ventimento: month+'-'+year, id_cliente: indexClient})
    }
    return tipo_pagamento
}


function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min)
}


