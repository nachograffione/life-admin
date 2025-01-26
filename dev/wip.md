## WIP
- Hacer front para tasks
  - Pensar que hacer con lo de weekdays, para mi lo mejor es sacarlo
  - Ver si current monthweek y eso no deberian moverse a shared
  - usar mockito para mockear y testear (sobre todo lo de current monthweek)
- Seguir con lo que está en Indigo en finances
  - Ya rehice el diagrama para WorkArrangementManager (ex SalariesManager)
    - El código hecho es obsoleto, hay que rehacer
  - Estaría bueno sacar aparte todo lo de Catalog que está junto con Budget, porque ahora se usa en WorkArrangements también


### How to release?
- Run 
  ```
  flutter build windows
  ```
- Copy ...\projectName\build\windows\runner\Release\ folder in Release desktop folder
  - The db_files data won't be overwritten, but keep a backup for more security


---
THESE ARE OLD DESIGNS FOR PENDING THINGS TO SOLVE:

package food {

enum Units #Indigo { g }

class Ingredient #Indigo { name:String } Ingredient --> "1" Metadata : metadata

class IngredientItem #Indigo { amount:Float ref:String } IngredientItem --> "1" Units : unit IngredientItem --> "1" Ingredient : ingredient

class Recipe #Indigo { plates:Int } Recipe --> "*" IngredientItem : ingredients Recipe --> "1" Metadata : metadata }
