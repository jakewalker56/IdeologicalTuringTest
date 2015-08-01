class Submission < ActiveRecord::Base
	belongs_to :topic
	belongs_to :professed_topic_option, class_name: "TopicOption"
	belongs_to :true_topic_option, class_name: "TopicOption"
	belongs_to :user
	has_many :votes

	def percentage_of_correct_votes
		return correct_votes.count / votes.count 
	end
	def average_confidence_of_correct_votes
		begin
			if has_correct_votes
				return correct_votes.collect{|v| v.confidence.to_i }.inject(:+)/correct_votes.count
			else 
				return 0
			end
		rescue
			return 0
		end
	end
	def average_confidence_of_incorrect_votes
		begin
			if has_incorrect_votes
				return incorrect_votes.collect{|v| v.confidence.to_i }.inject(:+)/incorrect_votes.count 
			else
				return 0
			end
		rescue
			return 0
		end
	end
	def correct_votes
		votes.select{|v| v.overall_vote == true_topic_option.id}
	end
	def incorrect_votes
		votes.select{|v| v.overall_vote != true_topic_option.id}
	end
	def has_correct_votes
		return correct_votes.count > 0
	end
	def has_incorrect_votes
		return incorrect_votes.count > 0
	end
end
