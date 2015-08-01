class ChangeStringToTopicOptionInSubmission < ActiveRecord::Migration
  def change
  	remove_column :submissions, :professed_belief, :string
  	remove_column :submissions, :true_belief, :boolean

  	add_column :submissions, :professed_topic_option_id, :integer
  	add_column :submissions, :true_topic_option_id, :integer
  end
end
