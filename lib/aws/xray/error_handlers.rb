module Aws
  module Xray
    class DefaultErrorHandler
      # @param [IO] io
      def initialize(io)
        @io = io
      end

      # @param [Exception] error
      # @param [String] payload
      # @param [String,nil] host
      # @param [Integer,nil] port
      def call(error, payload, host:, port:)
        @io.puts(<<-EOS)
Failed to send a segment to #{host}:#{port}:
Segment:
#{payload}
Error: #{error}
#{error.backtrace.join("\n")}
        EOS
      end
    end

    # Must be configured sentry-raven or sentry-ruby gem.
    class ErrorHandlerWithSentry
      ERROR_LEVEL = 'warning'.freeze

      def call(error, payload, host:, port:)
        if defined?(::Sentry)
          ::Sentry.capture_exception(
            error,
            level: ERROR_LEVEL,
            extra: { 'payload' => payload, 'payload_raw' => payload.unpack('H*').first }
          )
        elsif defined?(::Raven)
          ::Raven.capture_exception(
            error,
            level: ERROR_LEVEL,
            extra: { 'payload' => payload, 'payload_raw' => payload.unpack('H*').first }
          )
        end
      end
    end
  end
end
