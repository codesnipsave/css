class Snippet < ApplicationRecord
  belongs_to :user
  belongs_to :snippet, optional: true
  has_many :comments, dependent: :destroy
  has_many :snippets
  is_impressionable
  acts_as_votable
  has_many :snippet_tags
  has_many :tags, through: :snippet_tags
end
