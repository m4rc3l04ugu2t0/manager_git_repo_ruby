class Record
  def to_h
    object = {}
    instance_variables.each do |variable|
      object[variable.to_s.delete('@').to_sym] = instance_variables_get variable
    end

    object
  end

  def self.all
    table = CSV.read "#{new.base_path}", headers: true
    table.map do |item|
      data = item.to_h.transform_keys(&:to_sym)
      new(**data)
    end
  end
end
