class AddOnCertifiedSigningAgentAndLifeSettlementToNotaries < ActiveRecord::Migration
  def self.up
     add_column :notaries, :certified_signing_agent, :string
     add_column :notaries, :life_settlement_experience, :string
  end

  def self.down
    remove_column :notaries, :certified_signing_agent
    remove_column :notaries, :life_settlement_experience
  end
end
