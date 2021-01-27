class CreateRecipients < ActiveRecord::Migration[6.0]
  def change
    create_table :recipients do |t|
      t.string :postal_code,  null: false
      t.integer :area_id,  null: false
      t.string :city,  null: false
      t.string :address,  null: false
      t.string :building,  null: false
      t.string :telephone,  null: false
      t.references :purchase, foreign_key: true
      t.timestamps
    end
  end
end
