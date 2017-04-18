module Web::Controllers::Home
  class Index
    include Web::Action
    include Hanami::Action::Session

    expose :drawings, :drawing, :pooled_xem

    def call(params)
      @drawings = DrawingRepository.new.most_recent
      @drawing  = Drawing.new(address: params[:address], message: params[:message])
      @pooled_xem = pooled_uxem.to_f / 1_000_000
    end

    private

    def pooled_uxem
      $nis.account_get(address: ENV['NEM_ADDRESS'])[:account][:balance].to_i
    end
  end
end
