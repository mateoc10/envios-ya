class AddAttachmentDocumentationToDrivers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :drivers do |t|
      t.attachment :documentation
    end
  end

  def self.down
    remove_attachment :drivers, :documentation
  end
end
