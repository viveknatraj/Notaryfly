class AddLanguageAndCommercialLoanToNotary < ActiveRecord::Migration
  def self.up
		add_column :notaries, :commercial_loan, :string
		add_column :notaries, :billingual_language_1, :string
  end

  def self.down
		remove_column :notaries, :commercial_loan
		remove_column :notaries, :billingual_language_1
  end
end
