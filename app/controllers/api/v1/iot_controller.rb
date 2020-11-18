class Api::V1::IotController < Api::V1::BaseController
  def initialize
    initialize_interactions('Api::V1::Iot', %w[update find])
  end
end