class Api::V1::TranslateController < Api::V1::BaseController
  def initialize
    initialize_interactions('Api::V1::Translate', %w[index])
  end
end