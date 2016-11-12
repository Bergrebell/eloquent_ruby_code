class DocumentReader

  class << self
    attr_reader :reader_classes
  end

  @reader_classes = []

  def self.read(path)
    reader = reader_for(path)
    return nil unless reader
    reader.read(path)
  end

  def self.reader_for(path)
    reader_class = DocumentReader.reader_classes.find do |klass|
      klass.can_read?(path)
    end
    return reader_class.new(path) if reader_class
    nil
  end

  # wird aufgerufen sobald eine subklasse erstellt wird
  # (nicht erst wenn ein objekt instanziert wird)
  def self.inherited(subclass)
    DocumentReader.reader_classes << subclass
  end
end


class XMLReader < DocumentReader
  def self.can_read?(path)
    /.*\.xml/ =~ path
  end

  def initialize(path)
    @path = path
  end

  def read(path)
    # Lots of complicated XML stuff omitted
  end
end


class YAMLReader < DocumentReader
  def self.can_read?(path)
    /.*\.yaml/ =~ path
  end

  def initialize(path)
    @path = path
  end

  def read(path)
    # Lots of simple YAML stuff omitted
  end
end
