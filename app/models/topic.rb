class Topic < ActiveRecord::Base
	has_many :submissions
	has_many :topic_options
	accepts_nested_attributes_for :topic_options, :reject_if => lambda { |a| a[:value].blank? }, :allow_destroy => true

	def votes
		if submissions.present?
			return submissions.map {|s| s.votes}.inject(:+)
		end
		return nil
	end
	def correct_votes
		if submissions.present?
			return submissions.map {|s| s.correct_votes}.inject(:+)
		end
		return nil
	end
	def incorrect_votes
		if submissions.present?
			return submissions.map {|s| s.incorrect_votes}.inject(:+)
		end
		return nil
	end
	def average_confidence_of_correct_votes
		begin
			return correct_votes.collect{|v| v.confidence.to_i }.inject(:+)/correct_votes.count
		rescue
			return 0
		end
	end
	def average_confidence_of_incorrect_votes
		begin
			return incorrect_votes.collect{|v| v.confidence.to_i }.inject(:+)/incorrect_votes.count 	
		rescue
			return 0
		end
	end
	def voted_submissions(user)
		return submissions.select { |sub| sub.votes.where(user_id: user.id).count > 0 }
	end
	def non_voted_submissions(user)
		return submissions.select { |sub| sub.votes.where(user_id: user.id).count == 0 }
	end

end
