require './config/boot'

use Airbrake::Rack if MyApplication.env == 'production'

run MyApplication::Dispatcher.new
