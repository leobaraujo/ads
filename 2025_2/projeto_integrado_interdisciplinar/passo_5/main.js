document.getElementById("cadastroForm").addEventListener("submit", function (e) {
    e.preventDefault();
    let valid = true;

    const cpf = document.getElementById("cpf").value.trim();
    const nascimento = document.getElementById("nascimento").value;
    const telefone = document.getElementById("telefone").value.trim();

    const cpfError = document.getElementById("cpfError");
    const nascError = document.getElementById("nascError");
    const telError = document.getElementById("telError");

    cpfError.textContent = "";
    nascError.textContent = "";
    telError.textContent = "";

    // Validação CPF
    if (!/^[0-9]{11}$/.test(cpf)) {
        cpfError.textContent = "O CPF deve conter exatamente 11 dígitos numéricos.";
        valid = false;
    }

    // Validação de data de nascimento (maior de 18 anos)
    if (!nascimento) {
        nascError.textContent = "Informe a data de nascimento.";
        valid = false;
    } else {
        const dataNasc = new Date(nascimento);
        const hoje = new Date();
        const idade = hoje.getFullYear() - dataNasc.getFullYear();
        if (idade < 18 || (idade === 18 && hoje < new Date(dataNasc.setFullYear(dataNasc.getFullYear() + 18)))) {
            nascError.textContent = "O usuário deve ter 18 anos ou mais.";
            valid = false;
        }
    }

    // Validação Telefone
    if (!/^[0-9]{10,11}$/.test(telefone)) {
        telError.textContent = "O telefone deve conter DDD + número (10 ou 11 dígitos).";
        valid = false;
    }

    if (valid) {
        alert("Cadastro validado com sucesso!");
        e.target.reset();
    }
});
