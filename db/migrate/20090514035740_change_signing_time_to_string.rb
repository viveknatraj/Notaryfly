class ChangeSigningTimeToString < ActiveRecord::Migration
  def self.up
     change_column(:orders, :signing_time, :string)
  end

  def self.down
    change_column(:orders, :signing_time, :time)
  end
end
