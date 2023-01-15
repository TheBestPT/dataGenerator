const fs = require('fs')
const alojamento = require('../output/alojamento.json')

module.exports = { gen }

function gen(){
    fotos_alojamento = []
    for(let i = 0; i < 1000; i++){
        morada = alojamento[i].morada
        foto = './fotos/foto_alojamento_'+morada.replaceAll(' ', '').replaceAll(',', '_').toLowerCase()+'.jpg'
        fotos_alojamento.push({foto})
    }
    return fotos_alojamento
}


function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min)
}


