const mysql = require("mysql2/promise"); // Modificado para a versão com suporte a Promises
const fs = require("fs");
const path = require("path");
const { attachDatabasePool } = require("@vercel/functions");

class Database {
    #conexao;

    get conexao() {
        return this.#conexao;
    }

    constructor() {
        // Lógica de SSL adaptada para evitar falhas de leitura de ficheiro (ENOENT) na Vercel
        let sslConfig;
        const certPath = path.join(__dirname, "../certs/isrgrootx1.pem");
        
        if (fs.existsSync(certPath)) {
            // Se o ficheiro físico existir, utiliza-o
            sslConfig = {
                ca: fs.readFileSync(certPath),
                minVersion: "TLSv1.2",
                rejectUnauthorized: true
            };
        } else {
            // Se não encontrar o ficheiro (comum na Vercel), assume configurações nativas seguras
            // ou lê de uma variável de ambiente (ex: process.env.DB_SSL_CA)
            sslConfig = { 
                rejectUnauthorized: true 
            };
        }

        this.#conexao = mysql.createPool({
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

        attachDatabasePool(this.#conexao);
    }

    // Métodos simplificados com async/await graças ao mysql2/promise
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

// ==============================
// EXPORTAÇÃO DA INSTÂNCIA (SINGLETON)
// ==============================
// Exportamos a instância já criada (new Database()) em vez da Classe. 
// Assim, ao fazer require() nas rotas, o Node devolve este mesmo objeto com o Pool ativo.
const dbInstance = new Database();
module.exports = dbInstance;