module Web::Controllers::Drawings
  class Create
    include Web::Action
    include Hanami::Action::Session

    expose :drawing

    before :track_remote_ip

    def call(params)
      form = DrawingForm.new(
        address: params.get(:drawing, :address),
        amount:  xem(range: ENV['NEM_MIN_OUT'].to_i..ENV['NEM_MAX_OUT'].to_i),
        message: params.get(:drawing, :message) || ''
      )

      result = form.validate
      recent_drawings = DrawingRepository.new.recent_by_ipaddr(@remote_ip)

      if result.success? && recent_drawings.count < ENV['HOURLY_DRAWING_COUNT'].to_i
        rpa = request_prepare_announce(result.output)
        res = nis.transaction_prepare_announce(request_prepare_announce: rpa)

        @drawing = DrawingRepository.new.create(result.output.merge(
          tx: res.transaction_hash.to_s,
          ip: @remote_ip
        ))

        flash[:success] = "Tx: #{res.transaction_hash.to_s}"
      elsif recent_drawings.count > ENV['HOURLY_DRAWING_COUNT'].to_i
        @drawing = Drawing.new(result.output)

        flash[:danger] = 'Drawing limit has been exceeded.'
      else
        @drawing = Drawing.new(result.output)
      end

      redirect_to routes.root_path(address: @drawing.address, message: @drawing.message)
    end

    params do
      required(:drawing).schema do
        required(:address).filled
        required(:message).filled
      end
    end

    private

    def xem(range: 25..50)
      rand(range)
    end

    def nis
      @nis ||= $nis
    end

    def track_remote_ip
      @remote_ip = request.ip
    end

    def request_prepare_announce(address:, amount:, message: '')
      tx = ::Nis::Struct::Transaction.new(
        amount: amount * 1_000_000,
        recipient: address,
        signer:  ENV['NEM_PUBLIC_KEY'],
        message: ::Nis::Struct::Message.new(message),
        type:    ::Nis::Struct::Transaction::TRANSFER,
        timeStamp: ::Nis::Util.timestamp,
        deadline:  ::Nis::Util.timestamp + 43_200,
        version:   ::Nis::Struct::Transaction::TESTNET_VERSION_1
      )

      ::Nis::Struct::RequestPrepareAnnounce.new(
        transaction: tx,
        privateKey: ENV['NEM_PRIVATE_KEY']
      )
    end
  end
end
