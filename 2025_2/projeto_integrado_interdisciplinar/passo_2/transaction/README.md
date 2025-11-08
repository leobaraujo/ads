# Passo 2: FRAMEWORKS PARA DESENVOLVIMENTO DE SOFTWARE

## Atividade

Durante uma promoção bancária, a fintech FastPay enfrentou uma falha grave: transferências
duplicadas afetaram milhares de clientes, e o sistema apresentava latência elevada nas transações.

Erros como esse são comuns em aplicações que não implementam validações robustas e não
registram corretamente as operações.

No ambiente da TechMarket, uma API de transações financeiras também está sendo criada, e você
foi incumbido de projetar um endpoint seguro, validado e com retorno confiável para o cliente. Sua
tarefa está diretamente ligada à confiabilidade e precisão do sistema de pagamentos.

Crie um endpoint REST para realizar transferências financeiras com as seguintes funcionalidades:
- Validação de saldo;
- Registro da transação;
- Geração de um código único para a operação.

## Resolução

### Arquivos

- app/controllers/api/v1/transfers_controller.rb

### Exemplo

> Exemplo de requisição (curl)

```shell
curl -X POST http://127.0.0.1:3000/api/v1/transfers \
  -H "Content-Type: application/json" \
  -d '{
    "from_account_id": 1,
    "to_account_id": 2,
    "amount": 1200.50
  }'
```

> Resposta

```shell
{
  "success": true,
  "message": "Transferência simulada com sucesso!",
  "from_account": "Alice",
  "to_account": "Bob",
  "amount": 1200.5,
  "operation_code": "TRF-A3C91B2F",
  "timestamp": "2025-11-08 13:12:45"
}
```