//
//  ToDo.swift
//  RealmToDo
//
//  Created by Aybars Acar on 23/4/2022.
//

import Foundation
import RealmSwift

/// object managed by Realm
class ToDo: Object, ObjectKeyIdentifiable {
  // unique primary key
  @Persisted(primaryKey: true) var id: ObjectId
  
  @Persisted var name: String
  @Persisted var completed = false
  @Persisted var urgency: Urgency = .neutral
  
  enum Urgency: Int, PersistableEnum {
    case trivial, neutral, urgent
    
    var text: String {
      switch self {
      case .trivial:
        return "Trivial"
      case .neutral:
        return "Neutral"
      case .urgent:
        return "Urgent"
      }
    }
  }
  
  convenience init(name: String) {
    self.init()
    self.name = name
  }
}
