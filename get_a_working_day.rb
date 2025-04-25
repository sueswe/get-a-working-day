#!/usr/bin/env ruby

require "date"

holiday_csv = 'holiday.csv'
sdate = ARGV[0].to_s
if sdate.length != 8
  puts "argv0: invalid length."
  exit(2)
end

plus = ARGV[1].to_i


# returns 0 when workingday,
# returns 1 when weekend
def working?(datum)
  tag = datum.wday
  # wochentag = datum.strftime('%a')
  # Sunday = zero:
  if tag == 0 || tag == 6
    # puts " ... #{wochentag} "
    return 1
  else
    # puts "Finaly: a workingday: #{wochentag}"
    return 0
  end
end

# returns 0 when holiday,
# returns 1 when not a holiday
def holiday?(datum,csv)
  # convert date to yyyy-mm-dd
  theDate = datum.strftime('%Y-%m-%d')
  found = 1
  # puts "looking for: #{theDate}"
  File.open(csv) do |f|
    f.each_line do |line|
      if line.include?(theDate.to_s)
      # if line =~ /#{Regexp.escape(theDate)}/
        # puts "FOUND: #{line}"
        found = 0
      end
    end  
  end
  return found
end


def find_next_working_day(datum,file)
  # puts "calling recursionsFunktion ... mit #{datum}"
  if ( (working?(datum) == 0) && (holiday?(datum,file) == 1))
    dow = datum.strftime('%a')
    puts "#{dow}, #{datum}"
    return 0
  else
    dp = datum + 1
    # puts "erhoehe Datum auf #{dp}"
    find_next_working_day(dp,file)
  end
end


d = Date.parse(sdate)
d = Date.new(d.year,d.mon,d.mday)
d += plus
# puts "Is " + d.to_s + " a working day?"

#x = working?(d)
#puts x
#puts "-" * 20

#y = holiday?(d,holiday_csv)
#puts y
#puts "-" * 20

#if holiday?(d,holiday_csv) == 0
#  puts "ist ein Feiertag"
#else
#  puts "#{d} ist kein Feiertag"
#end

find_next_working_day(d, holiday_csv)


