class AddAddressIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :address, foreign_key: true
  end
end
