require 'uri'
require 'net/http'
require 'net/https'

module Hydna
  
  DEFAULT_CHANNEL   = "/"
  MAX_PAYLOAD_SIZE  = 0xFFF8
  MAX_TOKEN_SIZE    = 0xFFFF
  
  def self.emit(domain, data, ctoken=nil, agent='hydna-ruby-push')

    headers = {
      'Content-Type' => 'text/plain',
      'User-Agent' => agent,
      'X-Emit' => 'yes'
    }
    
    send(domain, headers, data)

  end

  def self.push(domain, data, prio=0, ctoken=nil, agent='hydna-ruby-push')

    headers = {
      'Content-Type' => 'text/plain',
      'User-Agent' => agent
    }
    
    prio = clean_prio(prio)

    headers['X-Priority'] = prio.to_s()

    send(domain, headers, data)

  end
  
  private
  
  def self.send(domain, headers, data)

    uri = parse_uri(domain)

    data = clean_payload(data)

    http = Net::HTTP::new(uri['host'], uri['port'])
    http.use_ssl = false
    
    if uri['scheme'] == 'https'
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    path = uri['channel']

    if uri['token'] != nil
      path = "%s?%s" % [uri['channel'], uri['token']]
    end
    
    begin
      resp, body = http.post(path, data, headers)
      if Integer(resp.code) != 200
        raise resp.message
      end
    rescue EOFError => e
    end
    return true

  end
  
  def self.clean_prio(prio)
    if !is_numeric(prio)
      raise "Priority needs to be a number 0-3"
    end

    if prio < 0 or prio > 3
      raise "Priority needs to be 0-3"
    end  

    return prio
  end

  def self.clean_payload(data)

    if data.bytesize == 0
      raise "Payload expected" 
    end

    if data.bytesize > MAX_PAYLOAD_SIZE
      raise "Payload exceeds maximum length allowed"
    end

    return data
  end

  def self.clean_token(token=nil)

    if token == nil
      return nil
    end

    if token.bytesize > MAX_TOKEN_SIZE
      raise "Token exceeds maximum length allowed"
    end

    return token

  end

  def self.is_numeric(str)
    begin Float(str) ; true end rescue false
  end

  def self.path_to_channel(query)
    if query.length < 2
      return DEFAULT_CHANNEL
    end
    
    channel = query

    return channel;
  end

  def self.parse_uri(domain)

    if domain.index("http") == nil
      domain = "http://%s" % domain
    end

    uri = URI.parse(domain)

    channel = path_to_channel(uri.path)
    
    token = clean_token(uri.query)

    return {
      'scheme' => uri.scheme,
      'host' => uri.host,
      'channel' => channel,
      'token' => token,
      'port' => uri.port
    }

  end
end