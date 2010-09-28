require 'rubygems'
require 'haml'

module Jekyll
  class Site
    def haml2html
      haml_folder = self.config['haml_folder'] || "_layouts/**/*.haml"
      compile_haml(haml_folder, /\.haml$/,'.html')
    end  

    private

    def compile_haml(files, input_regex, output_extension)
      Dir.glob(files).each do |f| 
        begin
          origin = File.open(f).read
          # the puts goes here so we know the file that failed to compile
          puts "Rendering #{f}"
          result = Haml::Engine.new(origin).render
          raise HamlErrorException.new if result.empty?
          output_file_name = f.gsub!(input_regex,output_extension)
          puts "saving #{output_file_name}"
          File.open(output_file_name,'w') {|f| f.write(result)} if !File.exists?(output_file_name) or (File.exists?(output_file_name) and result != File.read(output_file_name))
        rescue HamlErrorException => e
        end
      end
    end

  end

  class HamlErrorException < Exception
  end

  AOP.before(Site, :render) do |site_instance, result, args|
    site_instance.haml2html
  end
end
