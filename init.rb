require 'redmine' if Redmine::VERSION::MAJOR <= 1
require 'call_out_issue_patch'

Redmine::Plugin.register :redmine_call_out do
  name 'Redmine Call Out plugin'
  author 'OZAWA Yasuhiro'
  description 'Issue notification recipients add @name'
  version '0.0.1'
  url 'ihttps://github.com/ameya86/redmine_call_out'
  author_url 'http://blog.livedoor.jp/ameya86'
end
