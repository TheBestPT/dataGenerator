const fs = require('fs')
const anfitrioes = require('../output/anfitrioes.json')
const cliente = require('../output/clientes.json')
const comentarios = require('../data/Dados_Tabela_Classificacao_Anfitriao.json')

module.exports = { gen }

function gen(){
    classificacao_anfitriao = []
    for(let i = 0; i < 1000; i++){
        let comunicacao = randomIntFromInterval(1, 5)
        let tempo_resposta = randomIntFromInterval(1, 5)
        let comentario = comentarios[randomIntFromInterval(0, comentarios.length-1)].comentario
        let email_anfitriao = anfitrioes[randomIntFromInterval(0, anfitrioes.length - 1)].email
        let email_cliente = cliente[randomIntFromInterval(0, cliente.length - 1)].email
        classificacao_anfitriao.push({comunicacao: comunicacao, tempo_resposta: tempo_resposta, comentario: comentario, email_anfitriao: email_anfitriao, email_cliente: email_cliente})
    }
    return classificacao_anfitriao
}


function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min)
}


