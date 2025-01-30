# Finances

- CER ratio source
  - Use BCRA api
    _Why?_
    - _Because it's daily updated_
    - _datos.gob is not daily updated but with the same frequency as IPC, regardless what they say on the serie description (tested)_

## Facade, main components, dtos

```plantuml
@startuml lifeAdminModel
!theme reddress-darkblue
skinparam classAttributeIconSize 0
hide circle
<style>
  classDiagram {
    fontname "Arial"
    header {
      fontstyle bold
      fontsize 15
    }
    class {
      fontsize 13
    }
    note {
      fontsize 13
      backgroundColor grey
    }
  }
</style>

package finances {}
package shared {}

class shared.TagTreeNode

class finances.FinancesManager {
  --
  getInflationRate(reference:Datetime, interval:InflationRateInterval):Float
  ..
  getCatalogEntries():List<CatalogEntryDto>
  ..
  getBudgetEntries(filter:BudgetFilterDto):List<BudgetEntryDto>
  getBudgetEntriesSum(filter:BudgetFilterDto):PriceDto
  ' TODO: check return type
  getBudgetTags():List<TagDto>
  ..
  getWorkArrangements():List<WorkArrangementDto>
}

class finances.WorkArrangementManager #Indigo

class finances.Budget 

class finances.Catalog

class finances.InflationCalculator

' TODO: check if tagsTree should be owned by Budget
finances.FinancesManager ---> "1" shared.TagTreeNode : tagsTree
finances.FinancesManager -d-> "1" finances.WorkArrangementManager : workArrangementManager
finances.FinancesManager -d-> "1" finances.Budget : budget
finances.FinancesManager -d-> "1" finances.Catalog : catalog
finances.FinancesManager -d-> "1" finances.InflationCalculator : inflationCalculator

@enduml
```

```plantuml
@startuml lifeAdminModel
!theme reddress-darkblue
skinparam classAttributeIconSize 0
hide circle
<style>
  classDiagram {
    fontname "Arial"
    header {
      fontstyle bold
      fontsize 15
    }
    class {
      fontsize 13
    }
    note {
      fontsize 13
      backgroundColor grey
    }
  }
</style>

package finances {}

enum finances.InflationRateInterval {
  MTD
  YTD
  INTERANNUAL
}

class "finances.<ClassName>Dto"

class finances.BudgetFilterDto {
  tags:List<TagTreeNodeDto> [0..*]
  types:List<BudgetEntryTypeDto> [0..*]
  minPrice:Float [0..1]
  maxPrice:Float [0..1]
}

note as finances.n1
A BudgetEntry must match with 
each non-null field.
(AND-ed between fields, 
OR-ed inside each field).
Tags must be leaves.
end note

finances.BudgetFilterDto .d. finances.n1

@enduml
```

## Inflation

```plantuml
@startuml lifeAdminModel
!theme reddress-darkblue
skinparam classAttributeIconSize 0
hide circle
<style>
  classDiagram {
    fontname "Arial"
    header {
      fontstyle bold
      fontsize 15
    }
    class {
      fontsize 13
    }
    note {
      fontsize 13
      backgroundColor grey
    }
  }
</style>

package finances {}

class finances.InflationCalculator {
  getInflationRateFromDatetimes(from:Datetime, to:Datetime):Float
  getInflationRateFromReferenceAndInterval\n  (reference:Datetime, interval:InflationRateInterval):Float
}

class finances.InflationIndexProvider {
  getInflationIndex(datetime:Datetime):Float
}

class finances.InflationIndex {
  datetime
  value:Float
}

finances.InflationCalculator -d-> "1" finances.InflationIndexProvider : inflationIndexProvider
finances.InflationIndexProvider -d-> "*" finances.InflationIndex : inflationIndexSerie

@enduml
```

## Price

```plantuml
@startuml lifeAdminModel
!theme reddress-darkblue
skinparam classAttributeIconSize 0
hide circle
<style>
  classDiagram {
    fontname "Arial"
    header {
      fontstyle bold
      fontsize 15
    }
    class {
      fontsize 13
    }
    note {
      fontsize 13
      backgroundColor grey
    }
  }
</style>

package finances {}
package shared {}

interface finances.Priceable {
  getPrice():Price
}

class finances.Price #Indigo {
  value:Float
  absoluteError:Float
  getValue(currency:Currency):Float
}


class shared.Currency #Indigo {
  symbol:String
  referenceCurrencyValue:Float
  toCurrency(value:Float, currency:Currency):Float
}

note as shared.n1
The reference currency will be anyone
with a referenceCurrencyValue of 1.
end note

shared.Currency .r. shared.n1

finances.Price -d-> "1" shared.Currency : currency

finances.Price -r[hidden]-> finances.Priceable

@enduml
```

## Catalog

```plantuml
@startuml lifeAdminModel
!theme reddress-darkblue
skinparam classAttributeIconSize 0
hide circle
<style>
  classDiagram {
    fontname "Arial"
    header {
      fontstyle bold
      fontsize 15
    }
    class {
      fontsize 13
    }
    note {
      fontsize 13
      backgroundColor grey
    }
  }
</style>

package finances {}
package shared {}

class finances.Catalog {
  getEntries():List<CatalogEntry>
  updatePrices(inflationCalculator:InflationCalculator)
}

interface finances.Priceable {
}

class finances.CatalogEntry {
  adjustForInflation:Bool
  lastPriceUpdate:Datetime
  updatePrice(inflationCalculator:InflationCalculator)
}

class finances.CatalogEntryItem {
  factor:Float
}

class finances.Price {
}

class shared.Metadata {
}

finances.Catalog --> "*" finances.CatalogEntry : entries

finances.CatalogEntryItem ---> "1" finances.CatalogEntry : catalogEntry
finances.CatalogEntryItem .d.> finances.n1

finances.CatalogEntry ..u.|> finances.Priceable
finances.CatalogEntry --> "1" finances.Price : price
finances.CatalogEntry -d--> "1" shared.Metadata : metadata

finances.Catalog -r[hidden]-> finances.Priceable

@enduml
```

## Budget

```plantuml
@startuml lifeAdminModel
!theme reddress-darkblue
skinparam classAttributeIconSize 0
hide circle
<style>
  classDiagram {
    fontname "Arial"
    header {
      fontstyle bold
      fontsize 15
    }
    class {
      fontsize 13
    }
    note {
      fontsize 13
      backgroundColor grey
    }
  }
</style>

package finances {}
package shared {}

class finances.BudgetFilter {
  tags:List<TagTreeNode> [0..*]
  types:List<BudgetEntryType> [0..*]
  minPrice:Float [0..1]
  maxPrice:Float [0..1]
}

class finances.Budget {
  getEntries(filter:BudgetFilter):List<BudgetEntry>
  getEntriesPriceSum(filter:BudgetFilter):Price
}

interface finances.Priceable {
}

class finances.BudgetEntry {
}

enum finances.BudgetEntryType {
  EXPENSE
  INCOME
}

class finances.CatalogEntryItem {
}

class shared.Metadata {
}

finances.Budget --> "*" finances.BudgetEntry : entries

finances.BudgetEntry --> "*" finances.CatalogEntryItem : catalogEntryItems

finances.BudgetEntry .u.|> finances.Priceable

finances.BudgetEntry --> "1" finances.BudgetEntryType : type

finances.BudgetEntry ---> "1" shared.Metadata : metadata

finances.Budget -r[hidden]-> finances.Priceable

@enduml
```

## WorkArrangementManager

```plantuml
@startuml lifeAdminModel
!theme reddress-darkblue
skinparam classAttributeIconSize 0
hide circle
<style>
  classDiagram {
    fontname "Arial"
    header {
      fontstyle bold
      fontsize 15
    }
    class {
      fontsize 13
    }
    note {
      fontsize 13
      backgroundColor grey
    }
  }
</style>

package finances {}
package shared {}

class finances.WorkArrangementManager #Indigo {
  getWorkArrangements():List<WorkArrangement>
}

class finances.WorkArrangement #Indigo {
  getWorkingHours():Float 
}

enum finances.PayPeriod #Indigo { 
  HOURLY
  DAILY
  WEEKLY
  MONTHLY
  ANNUALLY
}

enum finances.WorkArrangementKind #Indigo {
  FREELANCE
  MIN_PART_TIME
  MAX_PART_TIME
  FULL_TIME
}

class finances.WorkingHoursCalculator #Indigo {
  minPartTimeHoursADay:Float
  maxPartTimeHoursADay:Float
  fullTimeHoursADay:Float
  daysAWeek:Float
  weeksAMonth:Float
  monthsAYear:Float
  getWorkingHoursOf(\nworkArrangementKind:WorkArrangementKind,\npayPeriod:PayPeriod):Float
}

class finances.HourPriceCalculator #Indigo {
  getHourPrice(\nworkArrangementKind: WorkArrangementKind):Price
}

finances.WorkArrangementManager -d-> "*" finances.WorkArrangement : workArrangements

finances.WorkArrangement .u.|> finances.Priceable
finances.WorkArrangement ----> "1" shared.Metadata : metadata
finances.WorkArrangement ---> "1" finances.WorkArrangementKind : kind
finances.WorkArrangement --> "1" finances.PayPeriod : payPeriod
finances.WorkArrangement --> "1" finances.WorkingHoursCalculator : workingHoursCalculator
finances.WorkArrangement --> "1" finances.HourPriceCalculator : hourPriceCalculator

finances.HourPriceCalculator --> "*" finances.CatalogEntryItem : referenceFullTimeMonthlySalaries

finances.WorkArrangementManager -r[hidden]-> finances.Priceable
@enduml
```