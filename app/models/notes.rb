class Notes < ActiveRecord::Base
  
  belongs_to :order

  def self.notesCount(user_id,order_id)
    @total_notes = Notes.find(:all, :conditions => ["user_id = ? AND order_id = ?",user_id, order_id])
        return @total_notes.size
    return
  end

  def self.view_notes(user_id,order_id)
    if user_id.present?
      @notes_view = Notes.find(:all, :conditions => ["user_id = ? AND order_id = ?", user_id, order_id], :order => "created_at DESC")
    else
      @notes_view = Notes.find(:all, :conditions => ["user_id is null AND order_id = ?", order_id], :order => "created_at DESC")
    end
  end

end
