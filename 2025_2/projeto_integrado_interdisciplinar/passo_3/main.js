const transactions = [
    {
        date: "2025-11-01",
        description: "Compra - Loja Online",
        amount: -320.9,
    },
    {
        date: "2025-11-02",
        description: "Transferência Recebida",
        amount: 7500.0,
    },
    {
        date: "2025-11-03",
        description: "Pagamento de Boleto",
        amount: -180.0,
    },
    { date: "2025-11-05", description: "Depósito Pix", amount: 5200.0 },
    { date: "2025-11-06", description: "Assinatura Mensal", amount: -39.9 },
    {
        date: "2025-11-07",
        description: "Transferência Enviada",
        amount: -5100.0,
    },
];

function formatCurrency(value) {
    return value.toLocaleString("pt-BR", {
        style: "currency",
        currency: "BRL",
    });
}

function renderTransactions() {
    const container = document.getElementById("statement");
    container.innerHTML = "";

    transactions.forEach((tx) => {
        const div = document.createElement("div");
        div.classList.add("transaction");
        if (Math.abs(tx.amount) >= 5000) div.classList.add("highlight");

        const details = document.createElement("div");
        details.classList.add("details");
        details.innerHTML = `<strong>${tx.description}</strong><br><span class="date">${tx.date}</span>`;

        const amount = document.createElement("div");
        amount.classList.add("amount");
        amount.classList.add(tx.amount > 0 ? "positive" : "negative");
        amount.textContent = formatCurrency(tx.amount);

        div.appendChild(details);
        div.appendChild(amount);
        container.appendChild(div);
    });
}

document.addEventListener("DOMContentLoaded", renderTransactions);
