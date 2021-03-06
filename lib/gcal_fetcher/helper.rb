  module GcalFetcher
  class Helper
  @@date_month_names = {:pt => %w(jan fev mar abr mai jun jul ago set out nov dez)}
    def self.split_compound_date date
      date = date.to_s if date.instance_of? DateTime
      arr = date.split(' ')
      date = arr[0..arr.size-4]
      begin_time = arr[arr.size-3] and end_time = arr[arr.size-1]
      begin
        begin_time = DateTime.parse(date+begin_time)
        end_time = DateTime.parse(date+end_time)
        return [begin_time,end_time]
      rescue
        return []
      end
    end
    def self.convert_date_to_en date, language='pt'
      raise ArgumentError unless date.is_a?(String) and date.include?(' ')
      date_arr = date.split(' ')
      day = date_arr[1].to_i rescue raise ArgumentError.new('Day must be an integer.')

    end
  
  end
end
