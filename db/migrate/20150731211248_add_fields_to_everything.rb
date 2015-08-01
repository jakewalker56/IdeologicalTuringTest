class AddFieldsToEverything < ActiveRecord::Migration
  def change
  	add_column :votes, :user_id, :integer
  	add_column :votes, :submission_id, :integer
  	add_column :votes, :value, :string
  	add_column :votes, :confidence, :float
  	
  	add_column :submissions, :user_id, :integer
  	add_column :submissions, :content, :text
  	add_column :submissions, :topic_id, :integer
  	add_column :submissions, :true_belief, :boolean
  	add_column :submissions, :professed_belief, :string
  	
  	add_column :topics, :name, :string
  	add_column :topics, :options, :text
  end
end
