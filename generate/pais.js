const fs = require('fs')
let allCountries = require('../data/countries.json').countries

module.exports = { gen }

function gen(){
    pais = []
    for(let i = 0; i < allCountries.length; i++){
        pais.push({nome_pais: allCountries[i].country})
    }
    return pais
}


function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min)
}


