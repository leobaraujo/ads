module Api
  module V1
    class TransfersController < ApplicationController
      protect_from_forgery with: :null_session

      # Endpoint: POST /api/v1/transfers
      def create
        # Simulando contas fictícias (sem banco de dados)
        accounts = {
          1 => { name: "Alice", balance: 5000.00 },
          2 => { name: "Bob", balance: 3000.00 }
        }

        from_id = params[:from_account_id].to_i
        to_id   = params[:to_account_id].to_i
        amount  = params[:amount].to_f

        # Validações simuladas
        if from_id == to_id
          render json: { error: "Contas de origem e destino não podem ser iguais." }, status: :unprocessable_entity
          return
        end

        if !accounts.key?(from_id) || !accounts.key?(to_id)
          render json: { error: "Conta não encontrada." }, status: :not_found
          return
        end

        if accounts[from_id][:balance] < amount
          render json: { error: "Saldo insuficiente para a operação." }, status: :unprocessable_entity
          return
        end

        # Simula a transferência (sem alterar valores reais)
        operation_code = "TRF-#{SecureRandom.hex(4).upcase}"

        render json: {
          success: true,
          message: "Transferência simulada com sucesso!",
          from_account: accounts[from_id][:name],
          to_account: accounts[to_id][:name],
          amount: amount,
          operation_code: operation_code,
          timestamp: Time.now.strftime("%Y-%m-%d %H:%M:%S")
        }, status: :ok
      end
    end
  end
end
