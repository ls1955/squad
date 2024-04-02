require "json"

class SQUAD
  attr_reader :version, :data

  def initialize(json_path)
    json = JSON.parse(File.read(json_path))
    @version, @data = json.values_at("version", "data")
  end

  def data_at(title)
    target = data.find { _1.title == title }

    return target if target

    {"title" => title, "paragraphs" => []}.tap { |new_data| data << new_data }
  end

  def to_json(*args)
    {"version" => version, "data" => data}.to_json(*args)
  end
end
