const fs = require('fs')
let comodidade = require('../data/dadosTabelaComodidade.json')
module.exports = { gen }
function gen(){
    comodidades = []
    for(let i = 0; i < 1000; i++){
        arr = []
        for(let j = 0; j < 15; j++){
            let random = comodidade[randomIntFromInterval(0, comodidade.length - 1)].descricao
            while(!arr.filter(e => {return e == random})) {
                random = comodidade[randomIntFromInterval(0, comodidade.length - 1)].descricao
            }
            arr.push(random)
        }
        comodidades.push({comodidade: arr})
    }
    return comodidades
}


function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min)
}


