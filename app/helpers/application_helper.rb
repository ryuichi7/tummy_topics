module ApplicationHelper

	def post_date(object)
		object.created_at.strftime('%m/%d/%Y')
	end

	def bootstrap_class_for(flash_type)
      puts flash_type.inspect
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do 
        concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
        concat message 
      end)
    end
    nil
  end

	def titleize(object)
		object.name.titleize
	end

	
end
