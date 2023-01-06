const fs = require('fs')
let citys = require('../data/postal_code_city_country.json')

module.exports = { gen }

function gen(){
    cidade = []
    for(let i = 0; i < citys.length; i++){
        let index = randomIntFromInterval(0, citys.length - 1)
        cidade.push({codigo_postal_cidade: citys[index].postalCode, nome_cidade: citys[index].city,id_pais: 0})
    }
    return cidade
}


function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min)
}


