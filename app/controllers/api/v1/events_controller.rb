class Api::V1::EventsController < Api::V1::AuthorizedController
  def initialize
    initialize_interactions('Api::V1::Events', %w[index show create update destroy search])
  end
end