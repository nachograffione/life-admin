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
}

class finances.SalariesManager #Indigo

class finances.Budget 

class finances.Catalog

class finances.InflationCalculator

' TODO: check if tagsTree should be owned by Budget
finances.FinancesManager ---> "1" shared.TagTreeNode : tagsTree
finances.FinancesManager -d-> "1" finances.SalariesManager : salariesManager
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

class finances.Catalog {
  getEntries():List<CatalogEntry>
  updatePrices(inflationCalculator:InflationCalculator)
}

interface finances.Priceable {
  getPrice():Price
}

class finances.BudgetEntry {
}

class finances.CatalogEntry {
  adjustForInflation:Bool
  lastPriceUpdate:Datetime
  updatePrice(inflationCalculator:InflationCalculator)
}

enum finances.BudgetEntryType {
  EXPENSE
  INCOME
}

class finances.CatalogEntryItem {
  factor:Float
}

class finances.Price #Indigo {
  value:Float
  absoluteError:Float
}

class shared.Metadata {
}

class shared.Currency #Indigo {
}

shared.Metadata -[hidden]r-> shared.Currency

finances.Budget ---> "*" finances.BudgetEntry : entries
finances.Catalog ---> "*" finances.CatalogEntry : entries

finances.BudgetEntry -r-> "*" finances.CatalogEntryItem : catalogEntryItems
finances.CatalogEntryItem -r-> "1" finances.CatalogEntry : catalogEntry

finances.CatalogEntry .u.|> finances.Priceable
finances.BudgetEntry .u.|> finances.Priceable

finances.CatalogEntry --> "1" finances.Price : price
finances.BudgetEntry --> "1" finances.BudgetEntryType : type

finances.Price -d-> "1" shared.Currency : currency

finances.CatalogEntry -d-> "1" shared.Metadata : metadata
finances.BudgetEntry -d-> "1" shared.Metadata : metadata

@enduml
```
