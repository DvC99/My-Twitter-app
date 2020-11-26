class CreateMensajes < ActiveRecord::Migration[6.0]
  def change
    create_table :mensajes do |t|
      t.integer :envia_id
      t.integer :recibe_id
      t.string  :mensaje

      t.timestamps
    end
  end
end
