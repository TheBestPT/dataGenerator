const fs = require('fs')
let alojamentos = require('../data/alojamentoRandomData.json')
let anfitrioes = require('../output/anfitrioes.json')
alojamentos = alojamentos.records

module.exports = { gen }

function gen(){
    alojamento = []
    for(let i = 0; i < alojamentos.length; i++){
        let codigo_indicativo
        let codigo_cidade
        if(alojamentos[i].fields.zipcode){
            if(alojamentos[i].fields.zipcode.search(" ") >= 0 || alojamentos[i].fields.zipcode.search("-") >= 0){
                codigo_indicativo = alojamentos[i].fields.zipcode.search(" ") >= 0 ? alojamentos[i].fields.zipcode.substring(2, alojamentos[i].fields.zipcode.length) : alojamentos[i].fields.zipcode.substring(alojamentos[i].fields.zipcode.search("-")+1, alojamentos[i].fields.zipcode.length)
                codigo_cidade = alojamentos[i].fields.zipcode.search(" ") >= 0 ? alojamentos[i].fields.zipcode.substring(0, 2) : alojamentos[i].fields.zipcode.substring(0, alojamentos[i].fields.zipcode.search("-"))
            }else{
                codigo_cidade = alojamentos[i].fields.zipcode.substring(0, 2)
                codigo_indicativo = alojamentos[i].fields.zipcode.substring(2, alojamentos[i].fields.zipcode.length)
            }
        }else{
            codigo_cidade = 'dne' 
            codigo_indicativo = 'dne'
        }

        let comudidades = []
        if(alojamentos[i].fields.amenities){
            let comudiadesStr = alojamentos[i].fields.amenities
            comudidades = comudiadesStr.split(',')
            //console.log(comudidades)
        }
        
        alojamento.push({descricao: alojamentos[i].fields.description.replaceAll("'", ""), morada: alojamentos[i].fields.street.replaceAll("'", ""), numero_maximo_pessoa: alojamentos[i].fields.guests_included + 1,
        numero_quartos: alojamentos[i].fields.bedrooms, nome: alojamentos[i].fields.street.replaceAll("'", ""), 
        codigo_postal_indicativo: codigo_indicativo, email_anfitriao: anfitrioes[i].email, codigo_postal_cidade: codigo_cidade,
        thumbnail: alojamentos[i].fields.thumbnail_url, gelocalizacao: alojamentos[i].fields.geolocation[0]+", "+alojamentos[i].fields.geolocation[1], 
    id_tipo_alojamento: alojamentos[i].fields.room_type, cidade: alojamentos[i].fields.city, pais: alojamentos[i].fields.country, comudidades})
    }

    return alojamento
}


function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min)
}


