class CreatePromocodes < ActiveRecord::Migration
  def self.up
    create_table :promocodes do |t|

      t.column :promocode,                     :string, :limit => 40
      t.column :credits,                       :string, :limit => 40
    end
  end

  def self.down
    drop_table :promocodes
  end
end
