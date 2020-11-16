class Api::V1::UsersController < Api::V1::AuthorizedController
  def initialize
    initialize_interactions('Api::V1::Users', %w[me index locale])
  end
end
