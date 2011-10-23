class Word < ActiveRecord::Base
  scope :todo, lambda { where "definition IS NULL OR definition = ''" }
end
