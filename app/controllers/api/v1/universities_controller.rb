class Api::V1::UniversitiesController < Api::V1::AuthorizedController
  def initialize
    initialize_interactions('Api::V1::Universities', %w[index])
  end

  def register_user
    run_interaction Api::V1::Universities::RegisterUser
  end
end