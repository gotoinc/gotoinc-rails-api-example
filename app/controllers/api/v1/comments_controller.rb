class Api::V1::CommentsController < Api::V1::AuthorizedController
  def initialize
    initialize_interactions('Api::V1::Comments', %w[create destroy])
  end
end