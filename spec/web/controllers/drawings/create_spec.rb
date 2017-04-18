require 'spec_helper'
require_relative '../../../../apps/web/controllers/drawings/create'

describe Web::Controllers::Drawings::Create do
  let(:action) { Web::Controllers::Drawings::Create.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
