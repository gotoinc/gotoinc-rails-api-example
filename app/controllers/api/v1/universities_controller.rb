class Api::V1::UniversitiesController < Api::V1::BaseController
  def initialize
    initialize_interactions('Api::V1::Universities', %w[index])
  end
end