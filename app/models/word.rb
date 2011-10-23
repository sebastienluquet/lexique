class Word < ActiveRecord::Base
  scope :todo, lambda { where "definition IS NULL OR definition = ''" }
  has_many :linked_words
  accepts_nested_attributes_for :linked_words, :allow_destroy => true
  has_many :words, :through => :linked_words, :source => :linked_to
end
