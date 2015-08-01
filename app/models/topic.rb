class Topic < ActiveRecord::Base
	has_many :submissions
	has_many :topic_options
	accepts_nested_attributes_for :topic_options, :reject_if => lambda { |a| a[:value].blank? }, :allow_destroy => true

end
