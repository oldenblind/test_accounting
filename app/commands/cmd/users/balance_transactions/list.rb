class Cmd::Users::BalanceTransactions::List < Cmd::Base
  hash :period, default: nil do
    integer :start
    integer :end_period
  end

  object :user

  def execute
    list_scope.order(:created_at)
  end

  private

  def list_scope
    @list_scope ||= period.present? ? base_scope.between_dates(period[:start], period[:end_period]) : base_scope
  end

  def base_scope
    @base_scope ||= user.balance_transactions
  end
end
