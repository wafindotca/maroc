class CreateVistors < ActiveRecord::Migration[5.1]
  def change
    create_table :vistors do |t|
      t.string :username
      t.string :contact_number
      t.string :email

      t.timestamps
    end
  end
end
