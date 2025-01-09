# Requirements

## Finances

### 1.0 ✅
- I want to work with prices with value and absolute error
- I want to set a catalog with entries for things i used as price references
- I want to set budget entries, with
  - their prices as a function of catalog entries
  - tags
- I want to see my bugdet
  - with prices adjusted by inflation
  - as a table with columns name, price and description

### 2.0 ✅
- I want to work with either flat and nested tags
- I want to filter the table by tags
- I want price sum and percentage of total for each active tag, if they belong to the same nesting level
  - Including "other" if necessary

### 3.0
- I want to set desired salaries with their prices as a function of catalog entries
(FOR THIS BELOW, I PREFER TO USE 1 SALARY THAT HAS A GETWORKAMOUNT WITH A WORKARRANGEMENT AND A DURATION, AND IT RETURNS A PRICEABLE)
- I want to see a table for each salary with
  - columns
    - working hours
    - $
    - US$
  - rows
    - freelance hour
    - minPartTime day, week, month, year
    - maxPartTime day, week, month, year
    - fullTime day, week, month, year
- I want to set a transfer routine for investments purposes
- I want to add an investement budget entry with price updated using broker's API

## Tasks

### 1.0
- *kind of repetition: daily, workday, weekly, monthly

- I want to set a table of tasks with metadata, duration, week of month, weekday and optional startsAt
- I want to see the tasks of the current day
  - Divided by kind of repetition
  - I want to mark as done
- I want to see all tasks of some kind of repetition
- I want to see the sum of tasks durations of each day of month, divided by kind of repetition, and the free time

### 2.0
- I want to add task's constraints (relative to others)
- I want to use non-monthly tasks (think on it as annually tasks)