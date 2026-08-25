const mysql = require("mysql2");

let pool = null;

class Database {

    #conexao;

    get conexao() {
        return this.#conexao;
    }

    set conexao(conexao) {
        this.#conexao = conexao;
    }

    constructor() {

        this.#conexao = mysql.createPool({
            host: 'localhost', //endereço do nosso banco de dados na nuvem
            database: 'renove', //a database de cada um de vocês possui a nomenclatura PFS1_(RA)
            user: 'root', // usuario e senha de cada um de vocês é o RA
            password: '',
            waitForConnections: true,
            connectionLimit: 100, // Limite de conexões
            queueLimit: 0 // Sem limite na fila de conexões
        });
    }

    ExecutaComando(sql, valores = []) {

        let cnn = this.#conexao;

        return new Promise(function (res, rej) {

            cnn.query(sql, valores, function (error, results) {

                if (error) {
                    rej(error);
                }
                else {
                    res(results);
                }

            });

        });
    }

    ExecutaComandoNonQuery(sql, valores = []) {

        let cnn = this.#conexao;

        return new Promise(function (res, rej) {

            cnn.query(sql, valores, function (error, results) {

                if (error) {
                    rej(error);
                }
                else {
                    res(results.affectedRows > 0);
                }

            });

        });
    }

    ExecutaComandoLastInserted(sql, valores = []) {

        let cnn = this.#conexao;

        return new Promise(function (res, rej) {

            cnn.query(sql, valores, function (error, results) {

                if (error) {
                    rej(error);
                }
                else {
                    res(results.insertId);
                }

            });

        });
    }
}

module.exports = Database;