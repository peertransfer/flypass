class ApplicationController < Sinatra::Base
  set :views, MyApplication.views_path
  set :public_folder, MyApplication.public_folder
  set :logger, MyApplication.logger

  not_found do
    html_path = File.join(settings.public_folder, '404.html')
    File.read(html_path)
  end

  error do
    raise request.env['sinatra.error'] if self.class.test?

    File.read(File.join(settings.public_folder, '500.html'))
  end
end
