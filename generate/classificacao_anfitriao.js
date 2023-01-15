const fs = require('fs')
const comentarios = require('../data/Dados_Tabela_Classificacao_Anfitriao.json')

module.exports = { gen }

function gen(){
    classificacao_anfitriao = []
    for(let i = 0; i < 1000; i++){
        let comunicacao = randomIntFromInterval(1, 5)
        let tempo_resposta = randomIntFromInterval(1, 5)
        let comentario = comentarios[randomIntFromInterval(0, comentarios.length-1)].comentario
        classificacao_anfitriao.push({comunicacao: comunicacao, tempo_resposta: tempo_resposta, comentario: comentario})
    }
    return classificacao_anfitriao
}


function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min)
}


