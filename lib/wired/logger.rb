module Wired 
  require 'logging'

  # @return [Logging] The logger used internally by the library
  Log       = Logging.logger['wired']
  Log.level = :debug
end