module GcalFetcher
  class Item
    attr_accessor :title, :author, :begins_at, :ends_at, :fields, :status, :duration
    def initialize(entry)
      field_names = {:pt => %w(Quando Quem Situação Descrição), :en => ['When','Who','Event Status', 'Description'], :sys => %w(begins_at author status)}
      time_range_separators = {:pt => ' a ', :en => ' to '}
      br = entry.content.include?('<br />') ? '<br />' : '<br>'
      field_names.keys.each do |language|
        fields = field_names[language] and break if field_names[language].select{|name| entry.content[name]}.size > 0
        time_range_separator = time_range_separators[:language]
      end
      @title = entry.title 
      i = 0
      (lines = entry.content.split(br)).each do |line|
        line.strip!
        unless line.empty?
          var_name = line.split(':').first and var_value = line.gsub "#{var_name}:", ""
          if i == 0 #first one's the date.
            if var_value.include? time_range_separator
              @begins_at = DateTime.parse(var_value.split(time_range_separator).first) and @ends_at = DateTime.parse(var_value.split(time_range_separator).last)
              @duration = @ends_at - @begins_at
            else
              @begins_at = @ends_at = DateTime.parse(var_value)
            end
          elsif i == lines.size - 1 #last one, can be the description.
          
          else
            instance_variable_set("@"+field_names[:sys][i], var_value)
          end
          i = i.next
        end
      end
    end
  end
end
