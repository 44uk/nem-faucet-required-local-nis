class DrawingForm
  include Hanami::Validations

  ADDRESS_FORMAT = /[ABCDEFGHIJKLMNOPQRSTUVWXYZ234567]{40}/

  validations do
    required(:address) { format?(ADDRESS_FORMAT) }
  end
end
