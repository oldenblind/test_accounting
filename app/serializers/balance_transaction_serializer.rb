class BalanceTransactionSerializer
  include JSONAPI::Serializer
  attributes :delta, :target

  attribute :created_at_timestamp do |transaction|
    transaction.created_at.to_i
  end
end
