require 'pry'

LogInfo = Struct.new(:timestamp, :url, :ip_address, :user_agent)

class Parser
  def initialize(document)
    @document = document
    @parsed_logs = []
  end

  def parse
    @document.split("\n").each do |line|
      @parsed_logs << LogInfo.new(parse_timestamp(line), parse_url(line), parse_ip(line), parse_agent(line))
    end
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
end
