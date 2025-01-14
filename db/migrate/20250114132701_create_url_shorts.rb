class CreateUrlShorts < ActiveRecord::Migration[8.0]
  def change
    create_table :url_shorts do |t|
      t.string :title
      t.string :original_url
      t.string :shortener_url
      t.integer :click_count

      t.timestamps
    end
  end
end
