from datetime import date, timedelta

def allsundays(year):
    d = date(year, 1, 1)                    # January 1st
    # d += timedelta(days = 6 - d.weekday())  # First Sunday
    d += timedelta(days = (4 - d.weekday() + 7) % 7)   # First Friday
     
    while d.year == year:
       yield d
       d += timedelta(days = 7)

for d in allsundays(2023):
    print(d.strftime('- date: %Y%m%d'))
