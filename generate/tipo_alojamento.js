const fs = require('fs')
const { isTypedArray } = require('util/types')
let alojamentos = require('../data/alojamentoRandomData.json')
alojamentos = alojamentos.records

module.exports = { gen }

function gen(){
    tipo_alojamento = []
    for(let i = 0; i < alojamentos.length; i++){
        let exists = false

        for(let j = 0; j < tipo_alojamento.length; j++){
            if(i==0) break
            //console.log(tipo)
            if(tipo_alojamento[j].descricao == alojamentos[i].fields.room_type) {
                exists = true
                break
            }
        }
        if(exists) continue
        tipo_alojamento.push({descricao: alojamentos[i].fields.room_type, icon_tipo_alojamento: alojamentos[i].fields.room_type.replace(' ', '').replace('/', '')+'.png'})
    }
    return tipo_alojamento
}


function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min)
}


