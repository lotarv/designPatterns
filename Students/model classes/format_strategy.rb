require "yaml"
require "json"
class Data_strategy
    def read(filepath)
        raise NotImplementedError, "Method must be overriden"
    end

    def write(filepath,data)
        raise NotImplementedError, "Method must be overriden"
    end
end

class YAML_strategy < Data_strategy
    def read(filepath)
        return YAML.load_file(filepath, symbolize_names: true)
    end

    def write(filepath, data)
        string_to_write = YAML.dump(data)
        File.write(filepath, string_to_write)
    end
end

class JSON_strategy < Data_strategy
    def read(filepath)
        return JSON.parse(File.read(filepath), symbolize_names:true)
    end

    def write(filepath, data)
        string_to_write = JSON.pretty_generate(data)
        File.write(filepath, data)
    end
end