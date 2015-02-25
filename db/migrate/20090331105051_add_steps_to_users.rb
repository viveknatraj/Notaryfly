class AddStepsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :steps, :string
  end

  def self.down
    remove_column :users, :steps
  end
end
