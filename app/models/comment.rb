class Comment < ApplicationRecord
  belongs_to :snippet
  belongs_to :user
end
