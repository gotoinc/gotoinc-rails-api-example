class GroupMember < ApplicationRecord
  belongs_to :user
  belongs_to :group

  enum role: {
    student: 0,
    admin: 1
  }
end
