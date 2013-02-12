#!/usr/bin/env ruby
require "yaml"

repository = ARGV[0]
revision   = ARGV[1]
SETTING    = YAML.load_file(ARGV[2])

changed_output = `#{SETTING['PATH_TO_SVNLOOK']} changed #{repository} -r #{revision}`
SETTING['PATH_AND_URL_PAIR'].each{ | match, url |
  if match.instance_of?(Regexp)
    `curl #{url}` if changed_output.match( match )
  else
    `curl #{url}` if changed_output.match( Regexp.escape( match ) )
  end
}

