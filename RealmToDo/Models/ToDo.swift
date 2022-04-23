//
//  ToDo.swift
//  RealmToDo
//
//  Created by Aybars Acar on 23/4/2022.
//

import SwiftUI
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
    
    var color: Color {
      switch self {
      case .trivial:
        return .teal
      case .neutral:
        return .secondary
      case .urgent:
        return .red
      }
    }
  }
  
  func incrementUrgency() -> Urgency {
    switch urgency {
    case .trivial:
      return .neutral
    case .neutral:
      return .urgent
    case .urgent:
      return .trivial
    }
  }
  
  convenience init(name: String) {
    self.init()
    self.name = name
  }
}
