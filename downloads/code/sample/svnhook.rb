#!/usr/bin/env ruby

PATH_SVNLOOK='/usr/local/subversion-1.6.11/bin/svnlook'
MATCH_PATH_AND_JENKINS_URL_PAIR = [
  { :match_path  => Regexp.escape('trunk/mdcs2012/src/logic/Calyin/'),
    :jenkins_url => 'http://zida01d/jenkins/job/Calyin/build?delay=0sec' },
  { :match_path  => Regexp.escape('trunk/mdcs2012/src/logic/Mdcs/'),
    :jenkins_url => 'http://zida01d/jenkins/job/Mdcs/build?delay=0sec' },
  { :match_path  => Regexp.escape('trunk/mdcs2012/src/logic/db/'),
    :jenkins_url => 'http://zida01d/jenkins/job/mdcs_db/build?delay=0sec' }
]

changed_output = `#{PATH_SVNLOOK} changed #{ARGV[0]} -r #{ARGV[1]}`
MATCH_PATH_AND_JENKINS_URL_PAIR.each{ |pair|
  `curl #{pair[:jenkins_url]}` if changed_output.match(pair[:match_path])
}
