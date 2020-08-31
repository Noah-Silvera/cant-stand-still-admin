class AddTokensToRider < ActiveRecord::Migration[6.0]
  def change
    add_column :riders, :access_token_ciphertext, :text
    add_column :riders, :refresh_token_ciphertext, :text
  end
end
