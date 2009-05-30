module GcalFetcher
  class Item
    attr_accessor :title, :author, :begins_at, :ends_at, :fields, :status
    def initialize(entry)
      field_names = {:pt => %w(Quando Quem Situação), :en => ['When','Who','Event Status'], :sys => %w(begins_at author status)}
      #puts entry.title
      @title = entry.title
      br = entry.content.include?('<br />') ? '<br />' : '<br>'
      field_names.keys.each do |language|
        fields = field_names[language] and break if field_names[language].select{|name| entry.content[name]}.size > 0
      end
        i = 0
        entry.content.split(br).each do |line|
          line.strip!
          unless line.empty?
             var_name = line.split(':').first and var_value = line.split(':').last
             if i == 0 #Begin date
               @begins_at = @ends_at = DateTime.parse(var_value)
             else
              instance_variable_set("@"+field_names[:sys][i], var_value)
             end
             i += 1
          end
        end

    end
  end
end
