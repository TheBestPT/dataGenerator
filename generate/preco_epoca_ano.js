let alojamentos = require('../data/alojamentoRandomData.json')
alojamentos = alojamentos.records

module.exports = { gen }

function gen(){
    precoEpocaAno = []
    for(let i = 0; i < 1000; i++){
        let year = new Date().getFullYear()
        data_inicio_1 = '01-01-'+year
        data_fim_1 = '12-17-'+year
        preco_1 = randomIntFromInterval(20, 100)
        data_inicio_2 = '12-18-'+year
        data_fim_2 = '01-05-'+(year+1)
        preco_2 = randomIntFromInterval(preco_1 + 30, 300)
        precoEpocaAno.push({data_inicio: [data_inicio_1, data_inicio_2], data_fim : [data_fim_1, data_fim_2], preco: [preco_1, preco_2]})
    }
    return precoEpocaAno
}


function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min)
}


