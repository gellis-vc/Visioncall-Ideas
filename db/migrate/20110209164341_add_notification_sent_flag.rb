class AddNotificationSentFlag < ActiveRecord::Migration
  def self.up
    # This migration was renumbered, which may cause it to be run twice. Therefore self.up must be idempotent,
    # so we only create the columns if they don't already exist.
    add_column_if_missing :ideas,    :spam_checked, :boolean, :default => false, :null => false
    add_column_if_missing :comments, :spam_checked, :boolean, :default => false, :null => false
    add_column_if_missing :ideas,    :notifications_sent, :boolean, :default => false, :null => false
    add_column_if_missing :comments, :notifications_sent, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :comments, :notifications_sent
    remove_column :ideas,    :notifications_sent
    remove_column :comments, :spam_checked
    remove_column :ideas,    :spam_checked
  end
  
  def self.add_column_if_missing(table, column, type, opts = {})
    # PostgreSQL adapter apparently doesn't implement column_exists?, so we have to do it the hard way.
    
    if columns(table).select { |c| c.name == column.to_s }.empty?
      add_column table, column, type, opts
    end
  end
end
