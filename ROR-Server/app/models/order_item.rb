class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  
	 def self.bulk_create(order_items)
	 	Rails.logger.debug "items----#{order_items}----"
	    values = []
	    order_items.each do |order_item|
	      values.push("('#{order_item[:item_total]}', '#{order_item[:order_id]}', '#{order_item[:product_id]}','#{Time.new}', '#{Time.new}')")
	    end
	    query = <<-QUERY
	      insert into order_items(item_total, order_id, product_id,created_at, updated_at)
	      values #{values.join(', ')}
	      RETURNING *
	    QUERY
	    query = sanitize_sql(query)
	    ActiveRecord::Base.connection.execute(query)
	 end
end


