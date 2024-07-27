class ConvertPostIdToCommentable < ActiveRecord::Migration[7.0]
  def up
    return unless column_exists?(:likes, :post_id)

    # Move post_id values to commentable_id and set commentable_type to 'Post'
    execute <<-SQL
        UPDATE likes
        SET commentable_id = post_id, commentable_type = 'Post'
        WHERE commentable_id IS NULL
    SQL
  end

  def down
    # Optionally, move values back if needed for rollback
    return unless column_exists?(:likes, :commentable_id) && column_exists?(:likes, :commentable_type)

    execute <<-SQL
        UPDATE likes
        SET post_id = commentable_id
        WHERE commentable_type = 'Post'
    SQL
  end
end
