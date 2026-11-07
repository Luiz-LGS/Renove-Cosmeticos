
const mysql = require("mysql2");
const fs = require("fs");
const path = require("path");
const { attachDatabasePool } = require("@vercel/functions");

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

            host: process.env.DB_HOST,
            port: Number(process.env.DB_PORT || 4000),
            database: process.env.DB_NAME,
            user: process.env.DB_USER,
            password: process.env.DB_PASSWORD,

            ssl: {
                ca: fs.readFileSync(
                    path.join(__dirname, "../certs/isrgrootx1.pem")
                ),
                minVersion: "TLSv1.2",
                rejectUnauthorized: true
            },

            waitForConnections: true,
            connectionLimit: 5,
            maxIdle: 1,
            idleTimeout: 5000,
            queueLimit: 0,

            enableKeepAlive: true,
            keepAliveInitialDelay: 0,
            connectTimeout: 20000

        });

        attachDatabasePool(this.#conexao);

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
