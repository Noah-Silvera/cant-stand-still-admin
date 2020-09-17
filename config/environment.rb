# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# TODO - improve this poor logging
Rails.logger = Logger.new(STDOUT)
Rails.application.config.logger = ActiveSupport::Logger.new("log/#{Rails.env}.log")
Rails.logger.datetime_format = "%Y-%m-%d %H:%M:%S"
Rails.logger.formatter = proc do | severity, time, progname, msg |
  "#{time}, #{severity}: #{msg} from #{progname} \n"
end
