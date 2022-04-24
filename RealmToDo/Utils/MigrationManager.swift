//
//  MigrationManager.swift
//  RealmToDo
//
//  Created by Aybars Acar on 24/4/2022.
//

import Foundation
import RealmSwift

/// Handles the Realm database migration for data model updates
/// runs everytime the app launches and runs a migration if there are changes to the datamodel
final class MigrationManager {
  
  init() {
    updateSchema()
  }
  
  func updateSchema() {
    let config = Realm.Configuration(schemaVersion: 1) { migration, oldSchemaVersion in
      if oldSchemaVersion < 1 {
        migration.enumerateObjects(ofType: Country.className()) { _, newObject in
          newObject!["flag"] = "🏳"
        }
      }
    }
    
    Realm.Configuration.defaultConfiguration = config
    
    let _ = try! Realm()
  }
}
