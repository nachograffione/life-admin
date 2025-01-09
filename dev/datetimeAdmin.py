import datetime

from model.datetime.weekday import Weekday


def get_day_of_month(dt):
    return dt.day


def monday_of_first_week(year, month):
    first_day_of_month = datetime.datetime(year, month=month, day=1)
    weekday = first_day_of_month.weekday()
    # This is equivalent to:
    # if weekday <= 3:
    #   first_day_of_month - weekday
    # else:
    #   first_day_of_month + (7-weekday)
    offset = weekday if weekday <= 3 else weekday - 7
    return first_day_of_month - \
        datetime.timedelta(days=offset)


def get_week_of_month(dt):
    monday_of_week = dt - datetime.timedelta(days=dt.weekday())
    return (monday_of_week - monday_of_first_week(dt.year, dt.month)).days // 7
