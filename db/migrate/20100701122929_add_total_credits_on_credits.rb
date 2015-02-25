class AddTotalCreditsOnCredits < ActiveRecord::Migration
  def self.up
    add_column :credits, :total_credits, :integer, :after => 'credits'
  end

  def self.down
    remove_column :credits, :total_credits, :integer
  end
end
