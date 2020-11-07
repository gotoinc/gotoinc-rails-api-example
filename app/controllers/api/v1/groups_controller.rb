class Api::V1::GroupsController < Api::V1::BaseController
  def initialize
    initialize_interactions('Api::V1::Groups', %w[index create])
  end
end