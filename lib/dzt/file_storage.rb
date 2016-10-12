module DZT
  class FileStorage
    #
    # @param destination: Full directory in which to output tiles, defaults to 'tiles' in the current dir.
    #
    def initialize(options = {})
      @store_path = File.join(Dir.pwd, 'public', options[:destination])
    end

    def exists?
      File.directory?(@store_path) && !Dir['@{@store_path}/*'].empty?
    end

    def storage_location(identifier = nil, level = nil)
      level.nil? ? @store_path : File.join(@store_path, identifier, level.to_s)
    end

    def mkdir(path)
      FileUtils.mkdir_p(path)
    end

    def write(file, dest, options = {})
      quality = options[:quality]
      file.write(dest) { self.quality = quality if quality }
    end

    def write_dzi(content, dest)
      File.open(dest, 'w') do |f|
        f.write(content)
      end
    end
  end
end
