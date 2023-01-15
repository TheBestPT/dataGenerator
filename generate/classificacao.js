const fs = require('fs')
const comentarios = require('../data/Dados_Tabela_Classificacao.json')
module.exports = { gen }

function gen(){
    classificacao = []
    for(let i = 0; i < 1000; i++){
        let limpeza = randomIntFromInterval(1, 5)
        let comunicacao = randomIntFromInterval(1, 5)
        let check_in = randomIntFromInterval(1, 5)
        let localizacao = randomIntFromInterval(1, 5)
        let qualidade_preco = randomIntFromInterval(1, 5)
        let comentario = comentarios[randomIntFromInterval(0, comentarios.length - 1)].comentario
        classificacao.push({limpeza: limpeza, comunicacao: comunicacao, check_in: check_in, localizacao: localizacao, qualidade_preco: qualidade_preco, comentario: comentario})
    }
    return classificacao
}


function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min)
}


