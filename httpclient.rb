require 'net/http'
require 'json'
require 'pry'
require './parser'

class HttpClient
  XOM_URL = 'https://xom-workbench.herokuapp.com/api/report'.freeze
  XOM_KEY = ENV['XOM_KEY']

  def fetch
    res = Net::HTTP.start(url.hostname, url.port, :use_ssl => url.scheme == 'https') do |http|
      http.request(set_headers)
    end

    if res.is_a?(Net::HTTPSuccess)
      puts '====================='
      puts res.inspect
      puts '====================='
      @repsonse = res
    else
      raise StandardError.new "Couldn't fetch URL"
    end
  end

  def parse
  end

  private

  def http_client
    
  end

  def url
    unless defined?(@url)
      @url = URI(XOM_URL)
      @url.query = URI.encode_www_form(request_params)
    end
    @url
  end

  def request_params
    {report_type: 'plain', nonce: 'uniq-random-string'}
  end

  def set_headers
    unless defined?(@headers)
      @headers = Net::HTTP::Get.new(url)
      @headers['Authorization'] = generate_authenticate_token
    end
    @headers
  end

  def generate_authenticate_token
    @hmac ||= OpenSSL::HMAC.hexdigest("SHA256", XOM_KEY, request_params.to_json)
  end
end


HttpClient.new.fetch