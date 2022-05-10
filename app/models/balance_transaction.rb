class BalanceTransaction < ApplicationRecord
  belongs_to :user

  scope :between_dates, ->(_start_date, _end_date) { where('created_at between ? and ?', start_data, end_period) }
end
