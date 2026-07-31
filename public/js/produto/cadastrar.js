document.addEventListener("DOMContentLoaded", function(){

    var btnGravar = document.getElementById("btnGravar");

    btnGravar.addEventListener("click", gravarProduto);
});

function gravarProduto() {

    var codigo = document.getElementById("codigo");
    var nome = document.getElementById("nome");
    var descricao = document.getElementById("descricao");
    var preco = document.getElementById("preco");
    var estoque = document.getElementById("estoque");
    var validade = document.getElementById("validade");
    var ativo = document.getElementById("ativo");
    var categoria = document.getElementById("categoria");
    var tipo = document.getElementById("tipo");
    var laboratorio = document.getElementById("laboratorio");
    var imagem = document.getElementById("imagem");

    if (codigo.value.trim() == "") {
        alert("Informe o código do produto.");
        codigo.focus();
        return;
    }

    if (nome.value.trim() == "") {
        alert("Informe o nome do produto.");
        nome.focus();
        return;
    }

    if (preco.value == "" || Number(preco.value) <= 0) {
        alert("Informe um preço maior que zero.");
        preco.focus();
        return;
    }

    if (estoque.value == "" || Number(estoque.value) <= 0) {
        alert("Informe uma quantidade em estoque maior que zero.");
        estoque.focus();
        return;
    }

    if (categoria.value == "" || categoria.value == "0") {
        alert("Selecione a categoria do produto.");
        categoria.focus();
        return;
    }

    if (tipo.value == "" || tipo.value == "0") {
        alert("Selecione o tipo do produto.");
        tipo.focus();
        return;
    }

    if (laboratorio.value == "" || laboratorio.value == "0") {
        alert("Selecione o laboratório do produto.");
        laboratorio.focus();
        return;
    }

    let formData = new FormData();

    formData.append("codigo", codigo.value.trim());
    formData.append("nome", nome.value.trim());
    formData.append("descricao", descricao.value);
    formData.append("preco", preco.value);
    formData.append("estoque", estoque.value);
    formData.append("validade", validade.value);
    formData.append("ativo", ativo.checked ? "s" : "n");
    formData.append("categoria", categoria.value);
    formData.append("tipo", tipo.value);
    formData.append("laboratorio", laboratorio.value);

    if(imagem.files.length > 0) {
        formData.append("imagem", imagem.files[0]);
    }

    fetch("/produtos/cadastrar", {
        method: "POST",
        body: formData
    })
    .then(r => r.json())
    .then(r => {
        if(r.ok) {
            alert("Produto cadastrado com sucesso!");
            window.location.href = "/produtos/listar";
        }
        else{
            alert(r.msg);
        }
    })
    .catch(e => {
        console.log(e);
        alert("Erro interno ao cadastrar produto.");
    });
}