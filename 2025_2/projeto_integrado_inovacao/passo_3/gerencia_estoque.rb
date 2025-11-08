# ============================
# Sistema de Gerenciamento de Estoque
# ============================

# Estruturas de dados
categorias = ["Eletrônicos", "Roupas", "Livros"]

produtos = {
  # Exemplo: "ID001" => {nome: "Notebook", categoria: "Eletrônicos", quantidade: 10, preco: 3500.0, localizacao: "A1"}
}

movimentacoes = [
  # Exemplo: {produto_id: "ID001", tipo: "entrada", quantidade: 5, data: "2025-11-08"}
]

# ============================
# Funções de Cadastro e Consulta
# ============================

def cadastrar_produto(produtos, produto_id, nome, categoria, quantidade, preco, localizacao)
  if produtos.key?(produto_id)
    return "Produto já cadastrado."
  end

  produtos[produto_id] = {
    nome: nome,
    categoria: categoria,
    quantidade: quantidade,
    preco: preco,
    localizacao: localizacao
  }
  "Produto cadastrado com sucesso."
end

def consultar_produto(produtos, produto_id)
  produto = produtos[produto_id]
  return "Produto não encontrado." unless produto

  "ID: #{produto_id}, Nome: #{produto[:nome]}, Categoria: #{produto[:categoria]}, Quantidade: #{produto[:quantidade]}, Localização: #{produto[:localizacao]}, Preço: R$#{'%.2f' % produto[:preco]}"
end

# ============================
# Funções de Movimentação de Estoque
# ============================

def registrar_entrada(produtos, movimentacoes, produto_id, quantidade, data)
  unless produtos.key?(produto_id)
    return "Produto não encontrado."
  end

  produtos[produto_id][:quantidade] += quantidade
  movimentacoes << {produto_id: produto_id, tipo: "entrada", quantidade: quantidade, data: data}
  "Entrada registrada com sucesso."
end

def registrar_saida(produtos, movimentacoes, produto_id, quantidade, data)
  unless produtos.key?(produto_id)
    return "Produto não encontrado."
  end

  if produtos[produto_id][:quantidade] < quantidade
    return "Estoque insuficiente."
  end

  produtos[produto_id][:quantidade] -= quantidade
  movimentacoes << {produto_id: produto_id, tipo: "saida", quantidade: quantidade, data: data}
  "Saída registrada com sucesso."
end

# ============================
# Funções de Relatórios
# ============================

def relatorio_estoque(produtos)
  puts "=== Relatório de Estoque ==="
  produtos.each do |produto_id, info|
    puts "ID: #{produto_id}, Nome: #{info[:nome]}, Categoria: #{info[:categoria]}, Quantidade: #{info[:quantidade]}, Localização: #{info[:localizacao]}, Preço: R$#{'%.2f' % info[:preco]}"
  end
end

def relatorio_movimentacoes(movimentacoes)
  puts "=== Relatório de Movimentações ==="
  movimentacoes.each do |mov|
    puts "Produto ID: #{mov[:produto_id]}, Tipo: #{mov[:tipo]}, Quantidade: #{mov[:quantidade]}, Data: #{mov[:data]}"
  end
end

# ============================
# Exemplo de uso
# ============================

# Cadastro de produto
puts cadastrar_produto(produtos, "ID001", "Notebook", "Eletrônicos", 10, 3500.0, "A1")
puts cadastrar_produto(produtos, "ID002", "Camiseta", "Roupas", 50, 59.90, "B2")

# Consulta de produto
puts consultar_produto(produtos, "ID001")
puts consultar_produto(produtos, "ID003")  # Produto não cadastrado

# Movimentações
puts registrar_entrada(produtos, movimentacoes, "ID001", 5, "2025-11-08")
puts registrar_saida(produtos, movimentacoes, "ID002", 10, "2025-11-08")

# Relatórios
relatorio_estoque(produtos)
relatorio_movimentacoes(movimentacoes)
