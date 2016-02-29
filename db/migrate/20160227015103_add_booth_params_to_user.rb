class AddBoothParamsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :class_year, :string
  	add_column :users, :gender, :string
  	add_column :users, :age, :integer
  	add_column :users, :political_affiliation, :string
  	add_column :users, :citizenship_status, :string
  end
end
