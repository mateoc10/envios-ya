class AddAttachmentLicenseToDrivers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :drivers do |t|
      t.attachment :license
    end
  end

  def self.down
    remove_attachment :drivers, :license
  end
end
