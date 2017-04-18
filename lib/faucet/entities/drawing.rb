class Drawing < Hanami::Entity
  ADDRESS_FORMAT = /[ABCDEFGHIJKLMNOPQRSTUVWXYZ234567]{40}/

  # attributes do
  #   attribute :address, Types::String.constrained(format: ADDRESS_FORMAT)
  #   attribute :message, Types::String
  #   attribute :amount , Types::Int
  #   attribute :tx     , Types::String
  #   attribute :ip     , Types::String
  #   attribute :created_at, Types::Time
  #   attribute :updated_at, Types::Time
  # end
end
