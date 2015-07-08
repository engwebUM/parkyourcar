class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.belongs_to :space, index: true, null: false
      t.string :file_name, null: false

      t.timestamps null: false
    end
  end
end
