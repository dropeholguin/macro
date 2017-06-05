class CreateUploads < ActiveRecord::Migration[5.0]
  def change
    create_table :uploads do |t|
      t.has_attached_file :image

      t.timestamps
    end
  end
end
