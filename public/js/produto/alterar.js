document.addEventListener("DOMContentLoaded", function(){

    var btnGravar = document.getElementById("btnAlterar");

    btnGravar.addEventListener("click", alterarProduto);

    let inputArquivo = document.getElementById("inputImagem");
    inputArquivo.addEventListener("change", carregarPrevia);
});

function carregarPrevia() {
    console.log(this.files);

    if(this.files.length > 0) {
        let img = document.getElementById("previaImagem");
        let urlImg = URL.createObjectURL(this.files[0]);
        img.src = urlImg;
        document.getElementById("divPrevia").style.display = "block";
    }
}

function alterarProduto() {

    var inputCodigoAtual = document.getElementById("inputCodigoAtual");
    var inputCodigo = document.getElementById("inputCodigo");
    var inputNome = document.getElementById("inputNome");
    var inputDescricao = document.getElementById("inputDescricao");
    var inputPreco = document.getElementById("inputPreco");
    var inputEstoque = document.getElementById("inputEstoque");
    var inputValidade = document.getElementById("inputValidade");
    var selAtivo = document.getElementById("selAtivo");
    var selCategoria = document.getElementById("selCategoria");
    var selTipo = document.getElementById("selTipo");
    var selLaboratorio = document.getElementById("selLaboratorio");
    var inputImagem = document.getElementById("inputImagem");

    if (inputCodigoAtual.value.trim() == "") {
        alert("Produto não encontrado para alteração.");
        return;
    }

    if (inputCodigo.value.trim() == "") {
        alert("Informe o código do produto.");
        inputCodigo.focus();
        return;
    }

    if (inputNome.value.trim() == "") {
        alert("Informe o nome do produto.");
        inputNome.focus();
        return;
    }

    if (inputPreco.value == "" || Number(inputPreco.value) <= 0) {
        alert("Informe um preço maior que zero.");
        inputPreco.focus();
        return;
    }

    if (inputEstoque.value == "" || Number(inputEstoque.value) <= 0) {
        alert("Informe uma quantidade em estoque maior que zero.");
        inputEstoque.focus();
        return;
    }

    if (selCategoria.value == "" || selCategoria.value == "0") {
        alert("Selecione a categoria do produto.");
        selCategoria.focus();
        return;
    }

    if (selTipo.value == "" || selTipo.value == "0") {
        alert("Selecione o tipo do produto.");
        selTipo.focus();
        return;
    }

    if (selLaboratorio.value == "" || selLaboratorio.value == "0") {
        alert("Selecione o laboratório do produto.");
        selLaboratorio.focus();
        return;
    }

    let formData = new FormData();

    formData.append("codigoAtual", inputCodigoAtual.value.trim());
    formData.append("codigo", inputCodigo.value.trim());
    formData.append("nome", inputNome.value.trim());
    formData.append("descricao", inputDescricao.value);
    formData.append("preco", inputPreco.value);
    formData.append("estoque", inputEstoque.value);
    formData.append("validade", inputValidade.value);
    formData.append("ativo", selAtivo.value);
    formData.append("categoria", selCategoria.value);
    formData.append("tipo", selTipo.value);
    formData.append("laboratorio", selLaboratorio.value);

    if(inputImagem.files.length > 0) {
        formData.append("imagem", inputImagem.files[0]);
    }

    fetch("/produtos/alterar", {
        method: "POST",
        body: formData
    })
    .then(r => r.json())
    .then(r => {
        if(r.ok) {
            alert("Produto alterado com sucesso!");
            window.location.href = "/produtos/listar";
        }
        else{
            alert(r.msg);
        }
    })
    .catch(e => {
        console.log(e);
        alert("Erro interno ao alterar produto.");
    });
}