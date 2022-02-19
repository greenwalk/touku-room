require File.expand_path(File.dirname(__FILE__) + "/environment")
# 出力先のログファイルの指定
set :output, 'log/cron.log'
# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数をセット
set :environment, rails_env

# 日本のタイムゾーン
def jst(time)
  Time.zone = 'Asia/Tokyo'
  Time.zone.parse(time).localtime($system_utc_offset)
end

# every 1.day, at:jst('3:22 pm') do
#   rake 'change_status:chage_field_status'
# end

# every 1.day, at: jst('3:25 pm') do
#   rake 'change_status:create_new_field'
# end