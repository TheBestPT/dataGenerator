const fs = require('fs')
const TIPO_RESERVA = ["Lazer", "Trabalho"]
module.exports = { gen }

function gen(){
    reserva = []
    for(let i = 0; i < 1000; i++){
        let mes = randomIntFromInterval(1, 12)
        let dia
        let ano = new Date().getFullYear()
        if(mes != 2 && mes <= 8) dia = (mes % 2 != 0) ? randomIntFromInterval(1, 31) : randomIntFromInterval(1, 30)
        else if (mes !=2)dia = (mes % 2 == 0) ? randomIntFromInterval(1, 31) : randomIntFromInterval(1, 30)
        else dia = leapyear(ano) ? randomIntFromInterval(1, 29) : randomIntFromInterval(1, 28)
        let check_in = mes+'-'+dia+'-'+ano
        noNeedToRandom = false
        if(mes == 12) {
            dia == 31 ? dia : ++dia
            noNeedToRandom = true
        }
        mes = randomIntFromInterval(mes == 12 ? 12 : mes + 1, 12)
        if(!noNeedToRandom)
            if(mes != 2 && mes <= 8)
                dia = (mes % 2 != 0) ? randomIntFromInterval(1, 31) : randomIntFromInterval(1, 30)
            else if (mes !=2)
                dia = (mes % 2 == 0) ? randomIntFromInterval(1, 31) : randomIntFromInterval(1, 30)
            else 
                dia = leapyear(ano) ? randomIntFromInterval(1, 29) : randomIntFromInterval(1, 28)
        //let check_out = mes+'-'+dia+'-'+ano
        let check_out = mes+'-'+dia+'-'+ano
        let numero_pessoas = randomIntFromInterval(1, 2)
        let status = 1
        let detalhes = 'Reserva confirmada'
        let tipo_reserva = TIPO_RESERVA[randomIntFromInterval(0, TIPO_RESERVA.length-1)]
        reserva.push({check_in, check_out, numero_pessoas, status, detalhes, numero_pessoas, status, detalhes, tipo_reserva})
    }
    return reserva
}


function leapyear(year){
    return (year % 100 === 0) ? (year % 400 === 0) : (year % 4 === 0);
}

function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min)
}


