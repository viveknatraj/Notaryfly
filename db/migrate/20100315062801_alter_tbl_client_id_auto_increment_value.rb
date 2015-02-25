class AlterTblClientIdAutoIncrementValue < ActiveRecord::Migration
 def self.up
     execute "ALTER TABLE clients AUTO_INCREMENT = 1000"
  end

  def self.down
     execute "ALTER TABLE clients AUTO_INCREMENT = 1"
  end
end
