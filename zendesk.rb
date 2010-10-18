require 'rubygems'
require 'rest_client'

class Zendesk
  SOLVED = 3

  def initialize(account, user, password)
    url     = "http://#{account}.zendesk.com"
    @client = RestClient::Resource.new(url, {:user => user, :password => password, :content_type => 'application/xml'})
  end

  def create_user(email, name)
    params = {:user => {:email => email, :name => name}}
    exec_stuff(:post, 'users', params)     
  end

  def create_ticket_for(user_id, description)
    params = {:ticket => {:requester_id => user_id, :description => description}} 
    exec_stuff(:post, 'tickets', params)
  end


  def solve_ticket!(ticket_id, comment=nil)
    url  = "tickets/#{ticket_id}"

    unless comment.nil?
      params = {:comment => {:is_public => true, :value => comment}}
      exec_stuff(:put, url, params)
    end

    params = {:ticket => {:status_id => SOLVED}}
    exec_stuff(:put, url, params)
  end

  private

  def exec_stuff(method, url, params)
    @client[url].send(method, params) do |response, request, result| 
      case response.code
      when 200
        return true
      when 201
        url = response.headers[:location]
        url =~ /(\d+).xml/
        id  = $1
        return id
      else
        raise response.body
      end
    end         
  end

end  

