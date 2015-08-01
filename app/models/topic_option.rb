class TopicOption < ActiveRecord::Base
	has_many :submissions, foreign_key: :professed_topic_option_id
	
	def voted_submissions(user)
		return submissions.select { |sub| sub.votes.where(user_id: user.id).count > 0 }
	end
	def non_voted_submissions(user)
		return submissions.select { |sub| sub.votes.where(user_id: user.id).count == 0 }
	end

end
