class AlterTblUsersLoginLength < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE users modify login VARCHAR(100)"
  end

  def self.down
    execute "ALTER TABLE users modify login VARCHAR(100)"
  end
end
