document.addEventListener("DOMContentLoaded", function () {

    const btn = document.getElementById("btnAlterar");

    const id = document.getElementById("id");
    const nome = document.getElementById("nome");
    const cpf = document.getElementById("cpf");
    const nascimento = document.getElementById("nascimento");
    const genero = document.getElementById("genero");
    const telefone = document.getElementById("telefone");
    const email = document.getElementById("email");
    const senha = document.getElementById("senha");
    const ativo = document.getElementById("ativo");

    function limparNumero(valor) {
        return valor.replace(/\D/g, "");
    }

    function aplicarMascaraCPF(valor) {
        valor = limparNumero(valor).slice(0, 11);
        valor = valor.replace(/(\d{3})(\d)/, "$1.$2");
        valor = valor.replace(/(\d{3})(\d)/, "$1.$2");
        valor = valor.replace(/(\d{3})(\d{1,2})$/, "$1-$2");
        return valor;
    }

    function aplicarMascaraTelefone(valor) {
        valor = limparNumero(valor).slice(0, 11);

        if (valor.length <= 10) {
            valor = valor.replace(/(\d{2})(\d)/, "($1) $2");
            valor = valor.replace(/(\d{4})(\d)/, "$1-$2");
        } else {
            valor = valor.replace(/(\d{2})(\d)/, "($1) $2");
            valor = valor.replace(/(\d{5})(\d)/, "$1-$2");
        }

        return valor;
    }

    function validarCPF(cpfValor) {
        cpfValor = limparNumero(cpfValor);

        if (cpfValor.length !== 11) return false;
        if (/^(\d)\1+$/.test(cpfValor)) return false;

        let soma = 0;

        for (let i = 0; i < 9; i++) {
            soma += parseInt(cpfValor.charAt(i)) * (10 - i);
        }

        let resto = (soma * 10) % 11;

        if (resto === 10 || resto === 11) resto = 0;
        if (resto !== parseInt(cpfValor.charAt(9))) return false;

        soma = 0;

        for (let i = 0; i < 10; i++) {
            soma += parseInt(cpfValor.charAt(i)) * (11 - i);
        }

        resto = (soma * 10) % 11;

        if (resto === 10 || resto === 11) resto = 0;
        if (resto !== parseInt(cpfValor.charAt(10))) return false;

        return true;
    }

    function validarEmail(emailValor) {
        return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(emailValor);
    }

    function validarNascimento(dataValor) {
        if (!dataValor) return false;

        const hoje = new Date();
        const nascimentoData = new Date(dataValor + "T00:00:00");

        if (nascimentoData > hoje) return false;

        let idade = hoje.getFullYear() - nascimentoData.getFullYear();
        const mes = hoje.getMonth() - nascimentoData.getMonth();

        if (
            mes < 0 ||
            (mes === 0 && hoje.getDate() < nascimentoData.getDate())
        ) {
            idade--;
        }

        return idade >= 18 && idade <= 120;
    }

    function validarTelefone(telefoneValor) {
        const numero = limparNumero(telefoneValor);

        if (numero.length !== 11) return false;

        const ddd = Number(numero.substring(0, 2));

        if (ddd < 11) return false;
        if (numero.charAt(2) !== "9") return false;

        return true;
    }

    function resetarBordas() {
        id.style.borderColor = "";
        nome.style.borderColor = "";
        cpf.style.borderColor = "";
        nascimento.style.borderColor = "";
        genero.style.borderColor = "";
        telefone.style.borderColor = "";
        email.style.borderColor = "";
        senha.style.borderColor = "";
    }

    cpf.value = aplicarMascaraCPF(cpf.value);
    telefone.value = aplicarMascaraTelefone(telefone.value);

    cpf.addEventListener("input", function () {
        cpf.value = aplicarMascaraCPF(cpf.value);
    });

    telefone.addEventListener("input", function () {
        telefone.value = aplicarMascaraTelefone(telefone.value);
    });

    btn.addEventListener("click", function () {

        resetarBordas();

        if (id.value.trim() === "") {
            id.style.borderColor = "red";
            id.focus();
            alert("Informe o ID do cliente.");
            return;
        }

        if (nome.value.trim() === "") {
            nome.style.borderColor = "red";
            nome.focus();
            alert("Informe o nome do cliente.");
            return;
        }

        if (!validarCPF(cpf.value)) {
            cpf.style.borderColor = "red";
            cpf.focus();
            alert("CPF inválido.");
            return;
        }

        if (!validarNascimento(nascimento.value)) {
            nascimento.style.borderColor = "red";
            nascimento.focus();
            alert("O cliente deve possuir idade entre 18 e 120 anos.");
            return;
        }

        if (genero.value === "") {
            genero.style.borderColor = "red";
            genero.focus();
            alert("Selecione o gênero.");
            return;
        }

        if (!validarTelefone(telefone.value)) {
            telefone.style.borderColor = "red";
            telefone.focus();
            alert("Telefone inválido. Informe DDD + número com 9 dígitos.");
            return;
        }

        if (!validarEmail(email.value.trim())) {
            email.style.borderColor = "red";
            email.focus();
            alert("E-mail inválido.");
            return;
        }

        if (senha.value.trim().length < 6) {
            senha.style.borderColor = "red";
            senha.focus();
            alert("A senha deve possuir no mínimo 6 caracteres.");
            return;
        }

        fetch("/cliente/alterar", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                id: id.value,
                nome: nome.value.trim(),
                cpf: cpf.value,
                nascimento: nascimento.value,
                genero: genero.value,
                telefone: telefone.value,
                email: email.value.trim(),
                senha: senha.value,
                ativo: ativo.checked ? "s" : "n"
            })
        })
            .then(function (resposta) {
                return resposta.json();
            })
            .then(function (corpo) {

                if (corpo.ok) {
                    alert("Cliente alterado com sucesso!");
                    window.location.href = "/cliente";
                } else {
                    alert(corpo.msg);
                }

            })
            .catch(function (erro) {
                console.error("ERRO AO ALTERAR CLIENTE:", erro);
                alert("Erro interno ao alterar cliente.");
            });

    });
});