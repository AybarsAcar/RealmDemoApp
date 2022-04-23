//
//  City.swift
//  RealmToDo
//
//  Created by Aybars Acar on 24/4/2022.
//

import Foundation
import RealmSwift

class City: Object, ObjectKeyIdentifiable {
  @Persisted(primaryKey: true) var id: ObjectId
  @Persisted var name: String
  
  convenience init(name: String) {
    self.init()
    self.name = name
  }
}
