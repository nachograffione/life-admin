# Shared

## Metadata

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

package shared {}

class shared.Metadata {
  name:String
  description:String
}

class shared.TagManager {
  hasTag(tag:TagTreeNode):void
}

class "shared.TagTreeNode" {
}

class shared.Tag {
  name:String
}

class "shared.TreeNode<T>" {
  data:T
  __
  ...
  treeMethods()
  ...
}

note as shared.n1
Tags must
be leaves.
end note

shared.Metadata --> "1" shared.TagManager : tagManager
shared.TagManager --> "*" "shared.TagTreeNode" : tags
"shared.TreeNode<T>" --> "*" "shared.TreeNode<T>" : children
"shared.TreeNode<T>" --> "1" "shared.TreeNode<T>" : parent
"shared.TreeNode<T>" <|.. "shared.TagTreeNode" : "<<bind>>T::Tag"
  "shared.TagTreeNode" --> "1" Tag : data
shared.TagManager .r. shared.n1

@enduml
```
- Tagging will be solved like this:
  - The user must
    - Create the tagsTree in the json file
      - The tree ensures partitions and unambiguous situations
      - Flat tags are just leaf tags that comes from the root node
    - Add leaf tags to entries
  - An tagged-object, through a TagManager, will hold multiple leaf tags
    - TagManager will check, at creation, that they are leaves
  - Tags are always used through TagTreeNode
    _Even if, for example, backends actually needs Tag objects only, not TagTreeNode ones, because the comparisons it has to make are simple since all tags are leaves_
    _This is to simplify the problem_

## Db

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

package shared {}

class shared.Db {
  userDataFilePath:String
  inflationIndexSerieFilePath:String
  createFinancesManager()
}

note as shared.n1
This class is responsible for 
creation of all objects from db.
The db will be a json file with the 
same structure as classes, and where
the "name" field will be used as the 
id for any referencing.
end note

shared.Db .. shared.n1

@enduml
```
