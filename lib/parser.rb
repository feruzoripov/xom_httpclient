require 'pry'
require 'digest'

LogInfo = Struct.new(:timestamp, :url, :ip_address, :user_agent) do
  def hash_ip_agent
    Digest::SHA256.hexdigest "#{ip_address}-#{user_agent}"
  end
end

class Parser
  attr_accessor :document

  def initialize(document=nil)
    @document = document
    @parsed_logs = []
  end

  def parse
    @document.split("\n").each do |line|
      @parsed_logs << LogInfo.new(parse_timestamp(line), parse_url(line), parse_ip(line), parse_agent(line))
    end
  end

  def calculate_unique_visits
    calculate_visits
    result = {}
    @visits_hash.each do |url, v_hash|
      result[url] = v_hash.uniq.size
    end

    result
  end

  private

  def parse_timestamp(log)
    log.scan(/\[([^;]*)\]/).first.first
  end

  def parse_url(log)
    log.scan(/\/([^\s]*),/).first.first
  end

  def parse_ip(log)
    log.scan(/,\s([^\s]*),/).first.first
  end

  def parse_agent(log)
    log.scan(/user-agent: ([^*]+)/).first.first
  end

  def calculate_visits
    @visits_hash = {}
    @parsed_logs.each do |log|
      if @visits_hash.key?(log.url)
        @visits_hash[log.url] << log.hash_ip_agent
      else
        @visits_hash[log.url] = [log.hash_ip_agent]
      end
    end
  end
end
