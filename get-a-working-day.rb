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
plus = ARGV[1].to_i


# returns 0 when workingday,
# # return 1 when weekend
def is_working(datum)
  tag = datum.wday
  wochentag = datum.strftime('%a')
  # Sunday = zero:
  if tag == 0 || tag == 6
    puts "Weekend: #{wochentag} "
    return 1
  else
    puts "Workingday: #{wochentag}"
    return 0
  end
end

def is_holiday
  csv = File.open(holiday_csv, mode = r)

  csv.Close
end



d = Date.parse(sdate)
d = Date.new(d.year,d.mon,d.mday)
d += plus
puts d.to_s

is_working(d)


