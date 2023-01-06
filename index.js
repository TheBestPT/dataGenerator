(async () => {
    const fs = require('fs')
    const { fstat } = require('fs');
    const query = require('./mssql')


    //let config = require('./config.json');  

    //connection.connect();

    let generateAfintriao = require('./generate/anfitrioes')
    let generateCliente = require('./generate/cliente')
    let generateCidade = require('./generate/cidade')
    let generatePais = require('./generate/pais')
    let generateMetodoPagamento = require('./generate/metodo_pagamento')
    let generateAlojamento = require('./generate/alojamento')
    let generateTipoAlojamento = require('./generate/tipo_alojamento')
    let generateClassificacao = require('./generate/classificacao')
    let generateClassificacaoAnfitriao = require('./generate/classificacao_anfitriao')
    let generateFotosAlojamento = require('./generate/fotos_alojamento')
    //let generateTipoAlojamento = require('./generate/tipo_alojamento')
    //fs.writeFileSync('./output/anfitrioes.json', JSON.stringify(generateAfintriaoOrClientes.gen()))
    //fs.writeFileSync('./output/clientes.json', JSON.stringify(generateCliente.gen()))
    //fs.writeFileSync('./output/cidade.json', JSON.stringify(generateCidade.gen()))
    //fs.writeFileSync('./output/pais.json', JSON.stringify(generatePais.gen()))
    //fs.writeFileSync('./output/metodo_pagamento.json', JSON.stringify(generateMetodoPagamento.gen()))
    //fs.writeFileSync('./output/alojamento.json', JSON.stringify(generateAlojamento.gen()))
    //fs.writeFileSync('./output/tipo_alojamento_en.json', JSON.stringify(generateTipoAlojamento.gen()))
    fs.writeFileSync('./output/classificacao.json', JSON.stringify(generateClassificacao.gen()))
    //fs.writeFileSync('./output/classificacao_anfitriao.json', JSON.stringify(generateClassificacaoAnfitriao.gen()))
    //fs.writeFileSync('./output/foto_alojamento.json', JSON.stringify(generateFotosAlojamento.gen()))

    let anfitrioes = require('./output/anfitrioes.json')
    let clientes = require('./output/clientes.json')
    let pais = require('./output/pais.json')
    let tipo_alojamento = require('./output/tipo_alojamento.json')
    let alojamento = require('./output/alojamento.json')
    let fotos_alojamento = require('./output/foto_alojamento.json')
    let classificacao = require('./output/classificacao.json')
    let classificacao_anfitriao = require('./output/classificacao_anfitriao.json')
    //await insertAnfitrioes(anfitrioes, query)
    //await insertClientes(clientes, query)
    //await insertCountries(pais, query)
    //await insertTipoAlojamento(tipo_alojamento, query)
    //await insertAlojamento(alojamento, query)
    //await insertFotosAlojamento(fotos_alojamento, query)
    //await insertClassificacao(classificacao, query)
    //await insertClassificacaoAnfitriao(classificacao_anfitriao, query)
})()



async function insertAnfitrioes(anfitrioes, query){
    for(let i = 0; i < anfitrioes.length; i++){
        sqlStr = `DECLARE @codigo_postal VARCHAR(9); EXEC adicionarCidadeEPais '${anfitrioes[i].pais}', '${anfitrioes[i].codigo_postal_cidade}', '${anfitrioes[i].cidade}', @codigo_postal OUTPUT; INSERT INTO Anfitriao (nome, data_nascimento, morada, codigo_postal_indicativo, genero, foto, contato_telefonico, contato_emergencia, superhost, email, password, codigo_postal_cidade) VALUES('${anfitrioes[i].nome}', '${anfitrioes[i].data_nascimento}', '${anfitrioes[i].morada}', '${anfitrioes[i].codigo_postal_indicativo}', '${anfitrioes[i].genero}', '${anfitrioes[i].foto}', '${anfitrioes[i].contato_telefonico}', '${anfitrioes[i].contato_emergencia}', ${anfitrioes[i].superhost == false ? 0 : 1}, '${anfitrioes[i].email}', '${anfitrioes[i].password}', @codigo_postal)`
        console.log(sqlStr)
        if(i != anfitrioes.length - 1)
            await query.execSql(sqlStr)
        else 
            await query.execSql(sqlStr, true)
    } 
}

async function insertClientes(clientes, query){
    for(let i = 0; i < clientes.length; i++){
        sqlStr = `DECLARE @codigo_postal VARCHAR(9); EXEC adicionarCidadeEPais '${clientes[i].pais}', '${clientes[i].codigo_postal_cidade}', '${clientes[i].cidade}', @codigo_postal OUTPUT; INSERT INTO Cliente (nome, data_nascimento, morada, codigo_postal_indicativo, genero, foto, contato_telefonico, contato_emergencia, email, password, codigo_postal_cidade) VALUES('${clientes[i].nome}', '${clientes[i].data_nascimento}', '${clientes[i].morada}', '${clientes[i].codigo_postal_indicativo}', '${clientes[i].genero}', '${clientes[i].foto}', '${clientes[i].contato_telefonico}', '${clientes[i].contato_emergencia}', '${clientes[i].email}', '${clientes[i].password}', @codigo_postal)`
        console.log(sqlStr)
        if(i != clientes.length - 1)
            await query.execSql(sqlStr)
        else 
            await query.execSql(sqlStr, true)
    } 
}

async function insertCountries(pais, query){
    for(let i = 0; i < pais.length; i++){
        sqlStr = `IF NOT EXISTS (SELECT nome_pais FROM pais WHERE nome_pais = '${pais[i].nome_pais}') INSERT INTO Pais (nome_pais) VALUES('${pais[i].nome_pais}') `
        console.log(sqlStr)
        if(i != pais.length - 1)
            await query.execSql(sqlStr)
        else 
            await query.execSql(sqlStr, true)
    } 
}


async function insertTipoAlojamento(tipo_alojamento, query){
    for(let i = 0; i < tipo_alojamento.length; i++){
        sqlStr = `IF NOT EXISTS (SELECT descricao FROM tipo_alojamento WHERE descricao = '${tipo_alojamento[i].descricao}') INSERT INTO tipo_alojamento (descricao, icon_tipo_alojamento) VALUES('${tipo_alojamento[i].descricao}', '${tipo_alojamento[i].icon_tipo_alojamento}') `
        console.log(sqlStr)
        if(i != tipo_alojamento.length - 1)
            await query.execSql(sqlStr)
        else 
            await query.execSql(sqlStr, true)
    } 
} 


async function insertAlojamento(alojamento, query){
    for(let i = 0; i < alojamento.length; i++){
        sqlStr = `EXEC inserirAnfitriao '${alojamento[i].nome}', '${alojamento[i].descricao}', '${alojamento[i].morada}', '${alojamento[i].gelocalizacao}', ${alojamento[i].numero_maximo_pessoa}, ${alojamento[i].numero_quartos}, '${alojamento[i].codigo_postal_indicativo}', '${alojamento[i].email_anfitriao}', '${alojamento[i].id_tipo_alojamento == "Entire home/apt" ? "apartamento/casa completo/a": alojamento[i].id_tipo_alojamento == "Private room" ? "quarto privado" : "quarto partilhado"}', '${alojamento[i].codigo_postal_cidade}', '${alojamento[i].pais}', '${alojamento[i].cidade}'`
        console.log(sqlStr)
        if(i != alojamento.length - 1)
            await query.execSql(sqlStr)
        else 
            await query.execSql(sqlStr, true)
    } 
} 

async function insertFotosAlojamento(foto_alojamento, query){
    for(let i = 0; i < foto_alojamento.length; i++){
        sqlStr = `DECLARE @id_anfitriao INT; DECLARE @id_alojamento INT; SELECT @id_anfitriao = id_anfitriao  FROM Anfitriao WHERE email = '${foto_alojamento[i].email_afintriao}'; SELECT @id_alojamento = id_alojamento FROM Alojamento WHERE id_alojamento = @id_anfitriao; INSERT INTO Foto_Alojamento (foto, id_alojamento) VALUES ('${foto_alojamento[i].foto}', @id_alojamento);`
        console.log(sqlStr)
        if(i != foto_alojamento.length - 1)
            await query.execSql(sqlStr)
        else 
            await query.execSql(sqlStr, true)
    } 
} 

async function insertClassificacao(classificacao, query){
    for(let i = 0; i < classificacao.length; i++){
        sqlStr = `DECLARE @id_anfitriao INT; DECLARE @id_alojamento INT; SELECT @id_anfitriao = id_anfitriao  FROM Anfitriao WHERE email = '${classificacao[i].email_anfitriao}'; SELECT @id_alojamento = id_alojamento FROM Alojamento WHERE id_alojamento = @id_anfitriao; DECLARE @id_cliente INT; SELECT @id_cliente = id_cliente FROM Cliente WHERE email = '${classificacao[i].email_cliente}'; INSERT INTO Classificacao (limpeza, comunicacao, check_in, localizacao, qualidade_preco, comentario, id_cliente, id_alojamento) VALUES(${classificacao[i].limpeza}, ${classificacao[i].comunicacao}, ${classificacao[i].check_in}, ${classificacao[i].localizacao}, ${classificacao[i].qualidade_preco}, '${classificacao[i].comentario}', @id_cliente, @id_alojamento);`
        console.log(sqlStr)
        if(i != classificacao.length - 1)
            await query.execSql(sqlStr)
        else 
            await query.execSql(sqlStr, true)
    } 
} 


async function insertClassificacaoAnfitriao(anfitrioes, query){
    for(let i = 0; i < anfitrioes.length; i++){
        sqlStr = `DECLARE @id_anfitriao INT; SELECT @id_anfitriao = id_anfitriao FROM Anfitriao WHERE email = '${anfitrioes[i].email_anfitriao}'; DECLARE @id_cliente INT; SELECT @id_cliente = id_cliente FROM Cliente WHERE email = '${anfitrioes[i].email_cliente}'; INSERT INTO Classificacao_anfitriao (comunicacao, tempo_resposta, comentario, id_cliente, id_anfitriao) VALUES(${anfitrioes[i].comunicacao}, ${anfitrioes[i].tempo_resposta}, '${anfitrioes[i].comentario}', @id_cliente, @id_anfitriao);`
        console.log(sqlStr)
        if(i != anfitrioes.length - 1)
            await query.execSql(sqlStr)
        else 
            await query.execSql(sqlStr, true)
    } 
} 