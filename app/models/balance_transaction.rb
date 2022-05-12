class BalanceTransaction < ApplicationRecord
  belongs_to :user

  scope :between_dates, ->(start_date, end_date) { where('created_at between ? and ?', start_date, end_date) }
end
