class AddOnVacationToNotaries < ActiveRecord::Migration
  def self.up
    add_column :notaries, :on_vacation, :boolean
  end

  def self.down
    remove_column :notaries, :on_vacation
  end
end
