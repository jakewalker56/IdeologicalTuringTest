class Topic < ActiveRecord::Base
	has_many :submissions
	has_many :topic_options
	accepts_nested_attributes_for :topic_options, :reject_if => lambda { |a| a[:value].blank? }, :allow_destroy => true

	
	def voted_submissions(user)
		return submissions.select { |sub| sub.votes.where(user_id: user.id).count > 0 }
	end
	def non_voted_submissions(user)
		return submissions.select { |sub| sub.votes.where(user_id: user.id).count == 0 }
	end

end
