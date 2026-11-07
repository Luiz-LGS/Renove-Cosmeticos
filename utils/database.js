const mysql = require("mysql2"); // Voltamos a importar a versão clássica
const fs = require("fs");
const path = require("path");
const { attachDatabasePool } = require("@vercel/functions");

class Database {
    #conexao;

    get conexao() {
        return this.#conexao;
    }

    constructor() {
        let sslConfig;
        const certPath = path.join(__dirname, "../certs/isrgrootx1.pem");
        
        if (fs.existsSync(certPath)) {
            sslConfig = {
                ca: fs.readFileSync(certPath),
                minVersion: "TLSv1.2",
                rejectUnauthorized: true
            };
        } else {
            sslConfig = { rejectUnauthorized: true };
        }

        // Cria o Pool clássico
        const rawPool = mysql.createPool({
            host: process.env.DB_HOST,
            port: Number(process.env.DB_PORT || 4000),
            database: process.env.DB_NAME,
            user: process.env.DB_USER,
            password: process.env.DB_PASSWORD,
            ssl: sslConfig,
            waitForConnections: true,
            connectionLimit: 5,
            maxIdle: 1,
            idleTimeout: 5000,
            queueLimit: 0,
            enableKeepAlive: true,
            keepAliveInitialDelay: 0,
            connectTimeout: 20000
        });

        // 1. Passa o pool original para a Vercel, para evitar o "Unsupported database pool type"
        attachDatabasePool(rawPool);

        // 2. Guarda a versão nativa de Promises na classe para o resto do código funcionar de forma limpa
        this.#conexao = rawPool.promise();
    }

    async ExecutaComando(sql, valores = []) {
        const [results] = await this.#conexao.query(sql, valores);
        return results;
    }

    async ExecutaComandoNonQuery(sql, valores = []) {
        const [results] = await this.#conexao.query(sql, valores);
        return results.affectedRows > 0;
    }

    async ExecutaComandoLastInserted(sql, valores = []) {
        const [results] = await this.#conexao.query(sql, valores);
        return results.insertId;
    }
}

const dbInstance = new Database();
module.exports = dbInstance;