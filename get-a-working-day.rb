require "date"

def date_calc_minus(number)
  d = Date.today
  number.times do
    d -= 1
    d -= 2 if d.sunday?
  end
  d
end

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
  wochentag = datum.strftime('%a')
  # Sunday = zero:
  if tag == 0 || tag == 6
    puts "is weekend ... #{wochentag} "
    return 1
  else
    puts "Finaly: a workingday: #{wochentag}"
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
        # puts "FOUND"
        found = 0
      end
    end  
  end
  return found
end


def find_next_working_day(datum,file)
  if ( (working?(datum) == 0) && (holiday?(datum,file) == 1) )
    # puts  "#{datum} : Workingday and not a Holiday"
    return 0
  else
    datum += 1
    find_next_working_day(datum,file)
  end
  return 1
end


d = Date.parse(sdate)
d = Date.new(d.year,d.mon,d.mday)
d += plus
# puts "Is " + d.to_s + " a working day?"

#working?(d)

#if holiday?(d,holiday_csv) == 0
#  puts "ist ein H"
#else
#  puts "ist kein H"
#end

if find_next_working_day(d, holiday_csv) == 0
  puts  "#{d} : Workingday and not a Holiday :D "
end

