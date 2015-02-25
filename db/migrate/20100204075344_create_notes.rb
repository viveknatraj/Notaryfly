class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.integer :order_id
      t.text :notes
      t.timestamps
    end
  end

  def self.down
    drop_table :notes
  end
end
