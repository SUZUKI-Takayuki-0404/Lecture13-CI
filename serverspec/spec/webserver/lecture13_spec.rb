require 'spec_helper'

listen_port80 = 80
listen_port22 = 22

# This is an example of a correctly configured network connection in serverspec
describe host('webserver') do
  it { should be_reachable }
  it { should be_resolvable.by('dns') }
end

# MariaDBがインストールされていないこと(＝検索結果に含まれない)
describe command('yum list installed | grep mariadb') do
  its(:stdout) { should match '' }
end

# gitがインストールされていること
describe package ('git') do
  it { should be_installed }
end

# ruby のバージョンは3.1.2であること
describe command('ruby -v') do
  its(:stdout) { should match 'ruby 3.2.3' }
end

# bundlerのバージョンは2.3.14であること
describe package('bundler') do
  it { should be_installed.by('gem').with_version('2.3.14') }
end

# railsのバージョンは7.0.4であること

describe package('rails') do
  it { should be_installed.by('gem').with_version('7.1.3.2') }
end

# nodeのバージョンは17.9.1であること
describe command('node -v') do
  its(:stdout) { should match 'v17.9.1' }
end

# yarnのバージョンは1.22.19であること
describe command('yarn -v') do
  its(:stdout) { should match '1.22.19' }
end

#ImageMagick7がインストール済であること
describe package('ImageMagick7') do
    it { should be_installed }
end

# Systemdがインストール済であること
describe package('systemd') do
  it { should be_installed }
end

# Nginxがインストール済であること
describe package('nginx') do
  it { should be_installed }
end

# nginxの自動起動設定がenableになっているか
describe service('nginx') do
  it { should be_enabled }
end

# ポート80番がリッスンであること
describe port(listen_port80) do
  it { should be_listening }
end

# ポート22番がリッスンであること
#describe port(listen_port22) do
#  it { should be_listening }
#end

# テスト接続して動作すること(ステータスコード200)
describe command('curl http://127.0.0.1:#{listen_port80}/_plugin/head/ -o /dev/null -w "%{http_code}\n" -s') do
  its(:stdout) { should match /^200$/ }
end
