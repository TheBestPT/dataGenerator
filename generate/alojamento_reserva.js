const fs = require('fs')
let clientes = require('../output/clientes.json')

module.exports = { gen }

function gen(){
    reserva = []
    for(let i = 0; i < reserva.length; i++){
        let mes = randomIntFromInterval(1, 12)
        let dia
        if(mes != 2 && mes <= 8) dia = (mes % 2 != 0) ? randomIntFromInterval(1, 31) : randomIntFromInterval(1, 30)
        else if (mes !=2)dia = (mes % 2 == 0) ? randomIntFromInterval(1, 31) : randomIntFromInterval(1, 30)
        else dia = randomIntFromInterval(1, 28)
        let ano = new Date().getFullYear()
        let check_in = dia+'-'+mes+'-'+randomIntFromInterval(ano, ano+2)
        mes = randomIntFromInterval(mes+1, 12)
        if(mes != 2 && mes <= 8) dia = (mes % 2 != 0) ? randomIntFromInterval(1, 31) : randomIntFromInterval(1, 30)
        else if (mes !=2)dia = (mes % 2 == 0) ? randomIntFromInterval(1, 31) : randomIntFromInterval(1, 30)
        else dia = randomIntFromInterval(1, 28)
        let check_out = dia+'-'+mes+'-'+randomIntFromInterval(ano, ano+2)
        let numero_pessoas = randomIntFromInterval(1, 2)
        let status = 1
        let detalhes = 'Reserva confirmada'
        let email_cliente = clientes[i].email
        reserva.push({check_in, check_out, numero_pessoas, status, detalhes, email_cliente})
    }
    return reserva
}


function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min)
}


