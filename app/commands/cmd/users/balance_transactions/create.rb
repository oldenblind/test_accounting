class Cmd::Users::BalanceTransactions::Create < Cmd::Base
  object :user

  hash :balance_transaction_params do
    integer :delta
    string :target
  end

  def execute
    user.with_lock do
      update_balance
      balance_transaction
    end
  end

  private

  def delta
    @delta ||= balance_transaction_params[:delta]
  end

  def update_balance
    user.update(balance: user.balance + delta)
  end

  def balance_transaction
    @balance_transaction ||= BalanceTransaction.create(balance_transaction_params.merge(user:))
  end
end
