class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :ochiai_url
      t.string :nerima_url
      t.string :toshimaen_url

      t.timestamps
    end
  end
end
