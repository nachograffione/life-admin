## WIP
- Hacer front para tasks
  - Pensar que hacer con lo de weekdays, para mi lo mejor es sacarlo
  - Ver si current monthweek y eso no deberian moverse a shared
  - usar mockito para mockear y testear (sobre todo lo de current monthweek)
- Seguir con lo que está en Indigo en finances

### How to release?
- Run 
  ```
  flutter build windows
  ```
- Copy ...\projectName\build\windows\runner\Release\ folder in Release desktop folder
  - The db_files data won't be overwritten, but keep a backup for more security


---


package food {

enum Units #Indigo { g }

class Ingredient #Indigo { name:String } Ingredient --> "1" Metadata : metadata

class IngredientItem #Indigo { amount:Float ref:String } IngredientItem --> "1" Units : unit IngredientItem --> "1" Ingredient : ingredient

class Recipe #Indigo { plates:Int } Recipe --> "*" IngredientItem : ingredients Recipe --> "1" Metadata : metadata }

package finances {

class finances.SalariesManager #Indigo { } finances.SalariesManager -d-> "*" Salary : salaries

' Salary -r[hidden]-> BudgetEntry

note left of Salary This class represents a single and independent criteria of a contract (with its period, amount of work and price). If in a particular use of the model every salaries share some features it doesn't matter, they will be still treated as isolated units, and finances.SalariesManager will be responsible to implement that features by creating instances in a certain common way. end note class Salary #Indigo { getWorkingHours():Float } Salary .d.|> Priceable Salary -r-> "1" Metadata : metadata Salary -r-> "1" WorkArrangement : workArrangement Salary -r-> "1" WorkingTimeRatios : WorkingTimeRatios Salary -r-> "1" PayPeriod : payPeriod

Salary -r-> "*" CatalogEntryItem : fullTimeMonthlySalaries }

package shared {

enum PayPeriod #Indigo { HOURLY DAILY WEEKLY MONTHLY ANNUALLY }

enum Currency #Indigo { ARS USD }

class WorkingTimeRatios #Indigo { minPartTimeHoursADay:Float maxPartTimeHoursADay:Float fullTimeHoursADay:Float daysAWeek:Float weeksAMonth:Float monthsAYear:Float getWorkingHoursOf(workArrangement:WorkArrangement, payPeriod:PayPeriod):Float }

enum WorkArrangement #Indigo { freelance minPartTime maxPartTime fullTime }

}
