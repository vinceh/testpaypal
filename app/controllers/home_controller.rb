class HomeController < ApplicationController

	def index

	end

	def pay
		gateway =  ActiveMerchant::Billing::PaypalAdaptivePayment.new(
            :login => "admin2_1332835502_biz_api1.gmail.com",
            :password => "1332835526",
            :signature => "APhBZT3go8aB2Satc1sE-PhTzKdfA87dlYIXam8Hxxaj6Jh7AfAhLeLA",
            :appid => "APP-80W284485P519543T" )

		recipients = [{:email => 'admin_1332814369_biz@gmail.com',
						 :amount => 5,
						 :primary => true},
						{:email => 'npo_1332820242_biz@gmail.com',
						 :amount => 10,
						 :primary => false}
						 ]

		response = gateway.setup_purchase(
				:return_url => url_for(:action => :complete, :only_path => false),
				:cancel_url => url_for(:action => :cancel, :only_path => false),
				:ipn_notification_url => url_for(:action => :success, :only_path => false),
				:receiver_list => recipients
		)

		redirect_to (gateway.redirect_url_for(response["payKey"]))
	end

	def complete
		redirect_to root_url
	end

	def cancel
		redirect_to root_url
	end

	def success
		redirect_to root_url
	end
end