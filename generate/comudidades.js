const fs = require('fs')
let alojamentos = require('../data/alojamentoRandomData.json')
alojamentos = alojamentos.records

module.exports = { gen }
//gen()
function gen(){
    comudidadesAll = []
    for(let i = 0; i < alojamentos.length; i++){
        let comudidades = []
        if(alojamentos[i].fields.amenities){
            let comudiadesStr = alojamentos[i].fields.amenities
            comudidades = comudiadesStr.split(',')
            
            for(let j = 0; j < comudidades.length; j++){
                if(comudidadesAll.filter(item => { return item.comudidade == comudidades[j] }).length >= 1)
                    continue
                comudidadesAll.push({comudidade: comudidades[j]})
            }
        }   
    }

    //return comudidades
    fs.writeFileSync('../output/comudiade.json', JSON.stringify(comudidadesAll))
}


function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min)
}


