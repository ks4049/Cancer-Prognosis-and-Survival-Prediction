class DataAnalyticsController < ApplicationController
	def get_analytics_data
        query="select p.user_id,p.quantity,p.product_id,products.name from (select orders.user_id,order_items.product_id,count(order_items.product_id) as quantity from orders inner join order_items on orders.id=order_items.order_id and user_id=#{params[:user_id]} and user_id is not NULL group by user_id,product_id) p inner join products on p.product_id=products.id;"
	    @result=ActiveRecord::Base.connection.execute(query).as_json
   	    Rails.logger.debug "res---#{@result}"
   	    cholestrol_data=Product.select(:id,:weight_in_kgs,:cholestrol_per_gm)
   	    @result.each_with_index do |res,i|
   	    	res=res.with_indifferent_access
   	    	cholestrol_data.each do |data|
   	    		if res[:product_id]==data.id
   	    			total_weight=res[:quantity]*(data.weight_in_kgs*1000)
   	    			cholestrol_level=total_weight*data.cholestrol_per_gm
   	    			@result[i].merge!(:cholestrol_level=>cholestrol_level)	
   	    		   break
 		  		  end
   	    	end
   	    end
   	    render json: @result
   	    Rails.logger.debug "final---==============\n #{@result}"
	end	

	def getItemsByUserId 
	    Rails.logger.debug "user_id----#{params[:user_id]}"
	    query="select * from (select product_id,order_id from order_items where order_id in (select id from orders where user_id=#{params[:user_id]})) items inner join products on products.id=items.product_id;"
	    @result1=ActiveRecord::Base.connection.execute(query).as_json
	    render json: @result1
	end
end
