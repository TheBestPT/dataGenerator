(async () => {
    const fs = require('fs')
    const mssql = require('./mssql')
    const readline = require('readline').createInterface({
        input: process.stdin,
        output: process.stdout,
    })
    readline.question(`Data generator for Projeto_AirBooking\n1 - Generate all data again.\n2 - Insert all data in database (NOTE: with this action you will delete all data in database!).\nType:`, async option => {
        switch(option){
            case "1":
                await generateAllData()
                readline.close()
                break
            case "2":
                await eraseAllData(mssql)
                await insertAllDataInDB(mssql)
                readline.close()
                break
            default:
                console.log('No option for that! Run the program again!')
                readline.close()
                break
        }
    })  
    //console.log = function() {}
    
    
})()

let start, end


function generateAllData(){
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
    let generatePrecoEpocaAno = require('./generate/preco_epoca_ano')
    let generateReserva = require('./generate/alojamento_reserva')
    let generateAdministradores = require('./generate/admin')
    let generateAlojamentoComodidade = require('./generate/alojamento_comodidade')
    fs.writeFileSync('./output/anfitrioes.json', JSON.stringify(generateAfintriao.gen()))
    fs.writeFileSync('./output/clientes.json', JSON.stringify(generateCliente.gen()))
    fs.writeFileSync('./output/cidade.json', JSON.stringify(generateCidade.gen()))
    fs.writeFileSync('./output/pais.json', JSON.stringify(generatePais.gen()))
    fs.writeFileSync('./output/metodo_pagamento.json', JSON.stringify(generateMetodoPagamento.gen()))
    fs.writeFileSync('./output/alojamento.json', JSON.stringify(generateAlojamento.gen()))
    fs.writeFileSync('./output/tipo_alojamento_en.json', JSON.stringify(generateTipoAlojamento.gen()))
    fs.writeFileSync('./output/classificacao.json', JSON.stringify(generateClassificacao.gen()))
    fs.writeFileSync('./output/classificacao_anfitriao.json', JSON.stringify(generateClassificacaoAnfitriao.gen()))
    fs.writeFileSync('./output/foto_alojamento.json', JSON.stringify(generateFotosAlojamento.gen()))
    fs.writeFileSync('./output/preco_epoca_ano.json', JSON.stringify(generatePrecoEpocaAno.gen()))
    fs.writeFileSync('./output/reserva.json', JSON.stringify(generateReserva.gen()))
    fs.writeFileSync('./output/admins.json', JSON.stringify(generateAdministradores.gen()))
    fs.writeFileSync('./output/alojamentoComodidade.json', JSON.stringify(generateAlojamentoComodidade.gen()))
}

async function insertAllDataInDB(mssql){
    start = Date.now()
    await mssql.connectBD()
    let anfitrioes = require('./output/anfitrioes.json')
    let clientes = require('./output/clientes.json')
    let pais = require('./output/pais.json')
    let tipo_alojamento = require('./output/tipo_alojamento.json')
    let alojamento = require('./output/alojamento.json')
    let fotos_alojamento = require('./output/foto_alojamento.json')
    let classificacao = require('./output/classificacao.json')
    let classificacao_anfitriao = require('./output/classificacao_anfitriao.json')
    let preco_epoca_ano = require('./output/preco_epoca_ano.json')
    let tipo_reserva = require('./output/tipo_reserva.json')
    let reserva = require('./output/reserva.json')
    let admins = require('./output/admins.json')
    let tipo_comodidades = require('./data/dadosTabelaTipoComodidade.json')
    let comodidades = require('./data/dadosTabelaComodidade.json')
    let alojamento_comodidade = require('./output/alojamento_comodidade.json')
    await insertCountries(pais, mssql)
    await insertAnfitrioes(anfitrioes, mssql)
    await insertClientes(clientes, mssql)
    await insertTipoAlojamento(tipo_alojamento, mssql)
    await insertAlojamento(alojamento, mssql)
    await insertFotosAlojamento(fotos_alojamento, mssql)
    await insertPrecoEpocaAno(preco_epoca_ano, mssql)
    await insertTipoReserva(tipo_reserva, mssql)
    await insertReservaAndPagamento(reserva, mssql)
    await insertClassificacao(classificacao, mssql)
    await insertClassificacaoAnfitriao(classificacao_anfitriao, mssql)
    await insertAdministradores(admins, mssql)
    await insertLogs(fotos_alojamento, mssql)
    await insertTiposComodidade(tipo_comodidades, mssql)
    await insertComodidade(comodidades, mssql)
    //await insertAlojamentoComodidade(alojamento_comodidade, mssql)
    end = Date.now()
    console.log(`Execution time: ${end - start} ms`)
    await mssql.close()
}

async function eraseAllData(mssql){
    console.log('Erasing All data....')
    await mssql.execSql(`EXEC sp_MSForEachTable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'; EXEC sp_MSForEachTable 'DELETE FROM ?'; EXEC sp_MSForEachTable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL'; EXEC sp_clearIdenity`)
    console.log('Erased All data.')
}


async function insertAnfitrioes(anfitrioes, mssql){
    for(let i = 0; i < anfitrioes.length; i++){
        sqlStr = `DECLARE @codigo_postal VARCHAR(9); EXEC adicionarCidadeEPais '${anfitrioes[i].pais}', '${anfitrioes[i].codigo_postal_cidade}', '${anfitrioes[i].cidade}', @codigo_postal OUTPUT; INSERT INTO Anfitriao (nome, data_nascimento, morada, codigo_postal_indicativo, genero, foto, contato_telefonico, contato_emergencia, superhost, email, password, codigo_postal_cidade) VALUES('${anfitrioes[i].nome}', '${anfitrioes[i].data_nascimento}', '${anfitrioes[i].morada}', '${anfitrioes[i].codigo_postal_indicativo}', '${anfitrioes[i].genero}', '${anfitrioes[i].foto}', '${anfitrioes[i].contato_telefonico}', '${anfitrioes[i].contato_emergencia}', ${anfitrioes[i].superhost == false ? 0 : 1}, '${anfitrioes[i].email}', '${anfitrioes[i].password}', @codigo_postal)`
    
        await mssql.execSql(sqlStr)
        printLog('Anfitrioes', i, anfitrioes.length)
    } 
    console.log('\nAnfitrioes Inserted!')
}

async function insertClientes(clientes, mssql){
    for(let i = 0; i < clientes.length; i++){
        sqlStr = `DECLARE @codigo_postal VARCHAR(9); EXEC adicionarCidadeEPais '${clientes[i].pais}', '${clientes[i].codigo_postal_cidade}', '${clientes[i].cidade}', @codigo_postal OUTPUT; INSERT INTO Cliente (nome, data_nascimento, morada, codigo_postal_indicativo, genero, foto, contato_telefonico, contato_emergencia, email, password, codigo_postal_cidade) VALUES('${clientes[i].nome}', '${clientes[i].data_nascimento}', '${clientes[i].morada}', '${clientes[i].codigo_postal_indicativo}', '${clientes[i].genero}', '${clientes[i].foto}', '${clientes[i].contato_telefonico}', '${clientes[i].contato_emergencia}', '${clientes[i].email}', '${clientes[i].password}', @codigo_postal); DECLARE @id_cliente INT; SET @id_cliente = IDENT_CURRENT('Cliente'); INSERT INTO metodo_pagamento (tipo_pagamento, nome_cartao, numero_cartao, cvc_codigo, data_vencimento, id_cliente) VALUES('${clientes[i].tipo_pagamento}', '${clientes[i].nome_cartao}', '${clientes[i].numero_cartao}', '${clientes[i].cvc_codigo}', '${clientes[i].data_vencimento}', @id_cliente);`
        await mssql.execSql(sqlStr)
        printLog('Clientes and Método Pagamento', i, clientes.length)
    } 
    console.log('\nClientes Inserted!')
}

async function insertCountries(pais, mssql){
    for(let i = 0; i < pais.length; i++){
        let paisIns = pais[i].nome_pais.replaceAll("'", " ")
        sqlStr = `INSERT INTO Pais (nome_pais) VALUES('${paisIns}') `
        await mssql.execSql(sqlStr)
        printLog('Países', i, +pais.length)
    } 
    //When the postal code is not specified we use 'dne' - Does not exist
    await mssql.execSql(`DECLARE @output VARCHAR(9); EXEC adicionarCidadeEPais 'dne', 'dne', 'dne', @output OUTPUT`)
    console.log('\nPaíses Inserted!')
}


async function insertTipoAlojamento(tipo_alojamento, mssql){
    for(let i = 0; i < tipo_alojamento.length; i++){
        sqlStr = `IF NOT EXISTS (SELECT descricao FROM tipo_alojamento WHERE descricao = '${tipo_alojamento[i].descricao}') INSERT INTO tipo_alojamento (descricao, icon_tipo_alojamento) VALUES('${tipo_alojamento[i].descricao}', '${tipo_alojamento[i].icon_tipo_alojamento}') `
        await mssql.execSql(sqlStr)
        printLog('Tipo Alojamento', i, tipo_alojamento.length)
    } 
    console.log('\nTipo Alojamento Inserted!')
} 


async function insertAlojamento(alojamento, mssql){
    for(let i = 0; i < alojamento.length; i++){
        sqlStr = `EXEC inserirAlojamento '${alojamento[i].nome}', '${alojamento[i].descricao}', '${alojamento[i].morada}', '${alojamento[i].gelocalizacao}', ${alojamento[i].numero_maximo_pessoa}, ${alojamento[i].numero_quartos}, '${alojamento[i].codigo_postal_indicativo}', '${i+1}', '${alojamento[i].id_tipo_alojamento == "Entire home/apt" ? "apartamento/casa completo/a": alojamento[i].id_tipo_alojamento == "Private room" ? "quarto privado" : "quarto partilhado"}', '${alojamento[i].codigo_postal_cidade}', '${alojamento[i].pais}', '${alojamento[i].cidade}'`
        await mssql.execSql(sqlStr)
        printLog('Alojamento', i, alojamento.length)
    } 
    console.log('\nAlojamentos Inserted!')
} 

async function insertFotosAlojamento(foto_alojamento, mssql){
    for(let i = 0; i < foto_alojamento.length; i++){
        sqlStr = `INSERT INTO Foto_Alojamento (foto, id_alojamento) VALUES ('${foto_alojamento[i].foto}', ${i+1});`
        await mssql.execSql(sqlStr)
        printLog('Fotos Alojamento', i, foto_alojamento.length)
    } 
    console.log('\nFotos Alojamento Inserted!')
} 

async function insertClassificacao(classificacao, mssql){
    for(let i = 0; i < classificacao.length; i++){
        sqlStr = `INSERT INTO Classificacao (limpeza, comunicacao, check_in, localizacao, qualidade_preco, comentario, id_cliente, id_alojamento) VALUES(${classificacao[i].limpeza}, ${classificacao[i].comunicacao}, ${classificacao[i].check_in}, ${classificacao[i].localizacao}, ${classificacao[i].qualidade_preco}, '${classificacao[i].comentario}', ${i+1}, ${i+1});`
        await mssql.execSql(sqlStr)
        printLog('Classificação', i, classificacao.length)
    } 
    console.log('\nClassificação Inserted!')
} 


async function insertClassificacaoAnfitriao(anfitrioes, mssql){//delete alojamento classificacaoAnfi
    for(let i = 0; i < anfitrioes.length; i++){
        sqlStr = `INSERT INTO Classificacao_anfitriao (comunicacao, tempo_resposta, comentario, id_cliente, id_anfitriao) VALUES(${anfitrioes[i].comunicacao}, ${anfitrioes[i].tempo_resposta}, '${anfitrioes[i].comentario}', ${i+1}, ${i+1});`
        await mssql.execSql(sqlStr)
        printLog('Classificação Anfitrião', i, anfitrioes.length)
    } 
    console.log('\nClassificação Anfitrião Inserted!')
} 

async function insertPrecoEpocaAno(preco_epoca_ano, mssql){//delete alojamento and preco por epoca de ano
    for(let i = 0; i < preco_epoca_ano.length; i++){
        for(let j = 0; j < preco_epoca_ano[i].data_inicio.length ; j++){
            sqlStr = `INSERT INTO preco_epoca_ano (data_inicio, data_fim, preco, id_alojamento) VALUES('${preco_epoca_ano[i].data_inicio[j]}', '${preco_epoca_ano[i].data_fim[j]}', ${preco_epoca_ano[i].preco[j]}, ${i+1})`
            await mssql.execSql(sqlStr)
            printLog('Preço por Época', i, preco_epoca_ano.length)
        }
    }
    console.log('\nPreço por Época Inserted!')
}



async function insertTipoReserva(tipo_reserva, mssql){//delete tipo reserva
    for(let i = 0; i < tipo_reserva.length; i++){
        sqlStr = `INSERT INTO tipo_reserva (descricao) VALUES('${tipo_reserva[i].descricao}')`
        await mssql.execSql(sqlStr)
        printLog('Tipo Reserva', i, tipo_reserva.length)
    } 
    console.log('\nTipo Reserva Inserted!')
} 

async function insertReservaAndPagamento(reserva, mssql){//delete pagamento and reserva
    for(let i = 0; i < reserva.length; i++){
        sqlStr = `DECLARE @preco FLOAT; EXEC sp_trackPrecoByDate '${reserva[i].check_in}', '${reserva[i].check_out}', ${i+1}, @preco OUTPUT; DECLARE @tipo_reserva INT; SELECT @tipo_reserva = id_tipo_reserva FROM tipo_reserva WHERE descricao = '${reserva[i].tipo_reserva}'; INSERT INTO reserva (check_in, check_out, numero_pessoas, preco, status, detalhes, id_alojamento, id_cliente, id_tipo_reserva) VALUES('${reserva[i].check_in}', '${reserva[i].check_out}', '${reserva[i].numero_pessoas}', @preco, ${reserva[i].status}, '${reserva[i].detalhes}', ${i+1}, ${i+1}, @tipo_reserva); DECLARE @id_reserva INT; SET @id_reserva = IDENT_CURRENT('Reserva'); INSERT INTO pagamento (preco, estado_pagamento, id_reserva, id_metodo_pagamento) VALUES(@preco, 'Pago', @id_reserva, @id_reserva)`
        await mssql.execSql(sqlStr)
        printLog('Reserva and Pagamento', i, reserva.length)
    } 
    console.log('\nReserva and Pagamento Inserted!')
}


async function insertAdministradores(admins, mssql){//delete pagamento and reserva
    for(let i = 0; i < admins.length; i++){
        sqlStr = `INSERT INTO Administrador (nome, data_nascimento, email, genero, contato_telefonico, password) VALUES('${admins[i].nome}', '${admins[i].data_nascimento}', '${admins[i].email}', '${admins[i].genero}', '${admins[i].contato_telefonico}', '${admins[i].password}')`
        await mssql.execSql(sqlStr)
        printLog('Administradores', i, admins.length)
    } 
    console.log('\nAdministradores Inserted!')
}

async function insertLogs(foto_alojamento, mssql){
    for(let i = 0; i < foto_alojamento.length; i++){
        sqlGen = `INSERT INTO Foto_Alojamento (foto, id_alojamento) VALUES ('${foto_alojamento[i].foto}', ${i+1});`
        sqlGen = sqlGen.replaceAll("'", "''")
        sqlStr = `INSERT INTO Logs (id_numero, id_nome, nome_tabela, comando_sql, tipo_evento, id_admin) VALUES(${i+1}, 'id_foto_alojamento', 'Foto_Alojamento', '${sqlGen}', 'adicionado', 1)`
        await mssql.execSql(sqlStr)
        printLog('Logs', i, foto_alojamento.length)
    }
    console.log('\nLogs Inserted!')
}

async function insertTiposComodidade(tipo_comodidades, mssql){
    for(let i = 0; i < tipo_comodidades.length; i++){
        icon = tipo_comodidades[i].descricao.replaceAll(' ', '_')
        icon = icon+'.png'
        sqlStr = `INSERT INTO Tipo_Comodidade (descricao, icon_tipo_comodidade) VALUES('${tipo_comodidades[i].descricao}', '${icon}')`
        await mssql.execSql(sqlStr)
        printLog('Tipo comodidade', i, tipo_comodidades.length)
    }
    console.log('\nTipo comodidade Inserted!')
}

async function insertComodidade(comodidades, mssql){
    for(let i = 0; i < comodidades.length; i++){
        sqlStr = `INSERT INTO Comodidade (descricao, id_tipo_comodidade) VALUES('${comodidades[i].descricao}', ${comodidades[i].id_tipo_comodidade})`
        await mssql.execSql(sqlStr)
        printLog('Comodidade', i, comodidades.length)
    }
    console.log('\nComodidade Inserted!')
}


async function insertAlojamentoComodidade(comodidades, mssql){
    for(let i = 0; i < comodidades.length; i++){
        for(let j = 0; j < comodidades[i].comodidade.length; j++){
            sqlStr = `DECLARE @id_comodidade INT; SELECT @id_comodidade = id_comodidade FROM Comodidade WHERE descricao = '${comodidades[i].comodidade[j]}'; INSERT INTO Alojamento_Comodidade (id_comodidade, id_alojamento) VALUES(@id_comodidade, ${i+1})`
            await mssql.execSql(sqlStr)
            printLog('Alojamento Comodidade', i+j, comodidades.length*15)
        }
    }
    console.log('\nAlojamento Comodidade Inserted!')
}




function printLog(str, i, length){
    process.stdout.clearLine(0);
    process.stdout.cursorTo(0);
    process.stdout.write(`Inserting ${str} ${i+1}:${length}`);
}