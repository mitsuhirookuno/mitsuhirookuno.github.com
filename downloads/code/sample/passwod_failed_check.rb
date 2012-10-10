#!/usr/bin/env ruby
require 'pp'

REGEXP_AUTH_FAILED=/Failed password for (root|invalid user ([^ ]+)) from (\d+\.\d+\.\d+\.\d+) port \d+ ssh2$/

def setDenyHostMap( map, user, ip_address )
    if map.key?(ip_address)
      user_map = map.fetch ip_address
    else
      user_map = Hash.new
    end
    if user_map.key?(user)
      user_map.store( user, (user_map.fetch(user)+1) )
    else
      user_map.store( user, 1 )
    end
    map.store( ip_address, user_map )
end

deny_host_map = Hash.new
open('/var/log/auth.log','r').read.split(/\n/).each{|line|
  line.scan(REGEXP_AUTH_FAILED){| root, user, ip_address |
    setDenyHostMap( deny_host_map, (user.nil?)? root:user, ip_address )
  }
}

puts deny_host_map.pretty_inspect
