class PrettyOutput
  def self.print headers, values
    headers = headers.join("\t\t")
    vals = values.map{ |k,v| v }
    puts headers

    values.each do |vals|
      case vals.class.to_s
      when "Hash"
        puts vals.map{ |k,v| v }.join("\t\t\t")
      when "Array"
        puts vals.join("\t\t\t")
      else
        puts vals
      end
    end
  end
end
