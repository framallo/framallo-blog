module Jekyll

  class HamlConverter < Converter
    safe false

    pygments_prefix '<notextile>'
    pygments_suffix '</notextile>'

    def setup
      return if @setup
      require 'haml'
      @setup = true
    rescue LoadError
      STDERR.puts 'You are missing a library required for HAML Please run:'
      STDERR.puts '  $ [sudo] gem install haml'
      raise FatalException.new("Missing dependency: haml")
    end

    def matches(ext)
      ext =~ /haml/i
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      setup
      options = @config[:haml] || {} 

      begin
        engine = ::Haml::Engine.new(content, options)

        if options[:debug]
          puts engine.precompiled
          puts '=' * 100
        end
        return result = engine.render
      rescue Exception => e
        #raise e if options[:trace]
        case e
        when ::Haml::SyntaxError
          puts "Syntax error on line #{get_line e}: #{e.message}"
        when ::Haml::Error
          puts "Haml error on line #{get_line e}: #{e.message}"
        else 
          puts "Exception on line #{get_line e}: #{e.message}\n  Use --trace for backtrace."
        end
      end # begin
    end # convert

    protected

    # Finds the line of the source template
    # on which an exception was raised.
    #
    # @param exception [Exception] The exception
    # @return [String] The line number
    def get_line(exception)
      # SyntaxErrors have weird line reporting
      # when there's trailing whitespace,
      # which there is for Haml documents.
      return (exception.message.scan(/:(\d+)/).first || ["??"]).first if exception.is_a?(::SyntaxError)
      (exception.backtrace[0].scan(/:(\d+)/).first || ["??"]).first
    end


  end # class
  end # module

