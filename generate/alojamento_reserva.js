const fs = require('fs')
const TIPO_RESERVA = ["Lazer", "Trabalho"]
module.exports = { gen }

function gen(){
    reserva = []
    for(let i = 0; i < 1000; i++){
        let mes = randomIntFromInterval(1, 12)
        let dia
        if(mes != 2 && mes <= 8) dia = (mes % 2 != 0) ? randomIntFromInterval(1, 31) : randomIntFromInterval(1, 30)
        else if (mes !=2)dia = (mes % 2 == 0) ? randomIntFromInterval(1, 31) : randomIntFromInterval(1, 30)
        else dia = randomIntFromInterval(1, 28)
        let ano = new Date().getFullYear()
        let check_in = ano+'-'+mes+'-'+dia
        mes = randomIntFromInterval(mes == 12? 12 : mes +1, 12)
        if(mes != 2 && mes <= 8) dia = (mes % 2 != 0) ? randomIntFromInterval(1, 31) : randomIntFromInterval(1, 30)
        else if (mes !=2)dia = (mes % 2 == 0) ? randomIntFromInterval(1, 31) : randomIntFromInterval(1, 30)
        else dia = randomIntFromInterval(1, 28)
        //let check_out = mes+'-'+dia+'-'+ano
        let check_out = ano+'-'+mes+'-'+dia
        let numero_pessoas = randomIntFromInterval(1, 2)
        let status = 1
        let detalhes = 'Reserva confirmada'
        let tipo_reserva = TIPO_RESERVA[randomIntFromInterval(0, TIPO_RESERVA.length-1)]
        reserva.push({check_in, check_out, numero_pessoas, status, detalhes, numero_pessoas, status, detalhes, tipo_reserva})
    }
    return reserva
}


function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min)
}


