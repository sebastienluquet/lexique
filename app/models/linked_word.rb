class LinkedWord < ActiveRecord::Base
  belongs_to :word
  belongs_to :linked_to, :class_name => 'Word'
  accepts_nested_attributes_for :linked_to
end
