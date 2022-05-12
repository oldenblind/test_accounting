class Api::V1::Users::BalanceTransactionsController < Api::V1::BaseController
  before_action :authenticate!

  def index
    outcome = Cmd::Users::BalanceTransactions::List.run(period.merge(user: current_user))

    if outcome.valid?
      render_models outcome.result.to_a
    else
      render_errors outcome.errors.to_hash
    end
  end

  def create
    outcome = Cmd::Users::BalanceTransactions::Create.run(user: current_user,
                                                          balance_transaction_params:)

    if outcome.valid?
      render_model outcome.result, status: 201
    else
      render_errors outcome.errors.to_hash
    end
  end

  private

  def balance_transaction_params
    params.require(:balance_transaction).permit(:target, :delta)
  end

  def period
    { start: params[:start], end_period: params[:end_period] }
  end
end
