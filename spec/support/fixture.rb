class Fixture
  class << self
    def load(name)
      case name
      when :sro_one_object,
           :sro_many_objects,
           :sro_many_objects_international,
           :sro_not_found
        read_file_for name
      else
        raise ArgumentError, "Fixture '#{name}' not found."
      end
    end

    private

    def read_file_for(filename)
      File.open("#{File.expand_path("../../", __FILE__)}/fixtures/#{filename}.xml").read
    end
  end
end
