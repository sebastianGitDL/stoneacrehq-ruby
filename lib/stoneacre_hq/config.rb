require 'logger'

module StoneacreHq

  DEFAULT_TIMEOUT = 15

  # Globally configures and retrieves configuration for the Stoneacre HQ.
  #
  # == Rails
  #
  # If running in a rails environment, this configuration will automatically use
  # the global Rails.logger instance. This behavior may be overridden by passing
  # in a :logger option.
  #
  # @param [Hash] options
  # @option options [String] :username (nil) StoneacreHQ account username
  # @option options [String] :password (nil) StoneacreHQ account password
  # @option options [Logger] :logger (Rails.logger) Logger to use
  # @option options [Numeric] :open_timeout (StoneacreHQ::DEFAULT_TIMEOUT)
  #   Number of seconds to wait for the connection to open
  #   (see Net::HTTP#open_timeout)
  # @option options [Numeric] :read_timeout (StoneacreHQ::DEFAULT_TIMEOUT)
  #   Number of seconds to wait for one block to be read
  #   (see Net::HTTP#read_timeout)
  # @option options [Boolean] :production (false) StoneacreHQ environment
  def self.config(options = nil)
    @config ||= {
      :username => '',
      :password => '',
      :api_key => '', # api_key should not be fixed, it should have to be obtained from token url.
      :logger => default_logger,
      :open_timeout => DEFAULT_TIMEOUT,
      :read_timeout => DEFAULT_TIMEOUT,
      :production => false
    }
    
    @config.merge!(options) if options

    @config
  end

  private

    def self.default_logger
      if defined?(::Rails)
        ::Rails.logger
      else
        logger = ::Logger.new(STDERR)
        logger.level = ::Logger::INFO
        logger
      end
    end

end
