class Api::V1::BuildingsController < Api::V1::AuthorizedController
  def initialize
    initialize_interactions('Api::V1::Buildings', %w[index create])
  end
end