class CreateFlycredits < ActiveRecord::Migration
  def self.up
    create_table :flycredits do |t|

     t.column :promocode,                     :string, :limit => 40
    end
  end

  def self.down
    drop_table :flycredits
  end
end
