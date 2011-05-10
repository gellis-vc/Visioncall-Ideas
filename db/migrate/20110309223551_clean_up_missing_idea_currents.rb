class CleanUpMissingIdeaCurrents < ActiveRecord::Migration
  def self.up
    Current.connection.execute("update ideas set current_id = #{Current::DEFAULT_CURRENT_ID} where current_id is null")
  end

  def self.down
  end
end
