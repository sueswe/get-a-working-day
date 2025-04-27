# README: looking for the next workingday after adding a given (positiv) offset (days)


See also Go-version : https://github.com/sueswe/getNextWorkingday-go

## Topic:

This code takes a date, adds an offset and calculates if the result 
is a workingday **and** not a holiday.
If not, it hopefully returns the next available workingday.

## Usage:

~~~sh
get_a_working_day.rb YYYY-MM-DD offset
~~~

## Example:

~~~sh
get_a_working_day.rb 2025-08-10 5
~~~

