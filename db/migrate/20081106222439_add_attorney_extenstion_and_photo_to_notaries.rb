class AddAttorneyExtenstionAndPhotoToNotaries < ActiveRecord::Migration
    def self.up
      add_column :notaries, :is_attorney, :string
      add_column :notaries, :work_extension, :string
    end

    def self.down
      remove_column :notaries, :is_attorney, :string
      remove_column :notaries, :work_extension, :string
    end
  end
