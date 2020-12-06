class Api::V1::UniversitiesNonAuthController < Api::V1::BaseController
  def initialize
    initialize_interactions('Api::V1::UniversitiesNonAuth', %w[create])
  end
end