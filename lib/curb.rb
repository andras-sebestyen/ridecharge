require 'net/http'
module Curb
	class Client
		include Singleton

		HOSTS = {
			development: "private-anon-efe910dfb9-curbrockpaperscissors.apiary-mock.com",
			staging: "private-anon-efe910dfb9-curbrockpaperscissors.apiary-proxy.com",
			production: "5eddt4q9dk.execute-api.us-east-1.amazonaws.com"
		}.freeze

		API_TIMEOUT_SEC = 3

		HOST = HOSTS[Rails.env.to_sym]

		attr_accessor :http

		def initialize
			@http = Net::HTTP.new(HOST)
			@http.read_timeout  = API_TIMEOUT_SEC
			@http.write_timeout = API_TIMEOUT_SEC
		end

		def choice
			send_request('GET', '/rps-stage/throw')
		end

		def send_request(method, path)
			response = @http.send_request(method, path)
			case response
			when Net::HTTPOK
				JSON.parse(response.body)['body']
			when Net::HTTPInternalServerError
				Rails.logger.warn("Internal server error")
				nil
			end
		rescue Net::ReadTimeout => e
			Rails.logger.warn("Request timeout")
			nil
		rescue => e
			Rails.logger.warn("Error occured while sending request! #{e.message}")
			nil
		end
	end

	def self.choice
		Client.instance.choice
	end
end