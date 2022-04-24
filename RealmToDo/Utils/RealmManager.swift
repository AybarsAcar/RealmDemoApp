//
//  RealmManager.swift
//  RealmToDo
//
//  Created by Aybars Acar on 24/4/2022.
//

import Foundation
import RealmSwift

/// Realm Database configuration class
/// Handles the Realm database migration for data model updates
final class RealmManager: ObservableObject {
  
  private(set) var realm: Realm?
  @Published private(set) var countries: Results<Country>?
  var countriesArray: [Country] {
    if let countries = countries {
      return Array(countries)
    }
    else {
      return []
    }
  }
  
  @Published var searchFilter = ""
  var searchResults: [Country] {
    if searchFilter.isEmpty {
      return countriesArray
    }
    else {
      return countriesArray.filter { $0.name.lowercased().contains(searchFilter.lowercased()) }
    }
  }
  
  private var countriesToken: NotificationToken?
  
  init(name: String) {
    initialiseSchema(name: name)
    setupObserver()
  }
  
  func setupObserver() {
    guard let realm = realm else {
      return
    }
    
    let observedCountries = realm.objects(Country.self)
    countriesToken = observedCountries.observe { [weak self] _ in
      self?.countries = observedCountries
    }
  }
  
  func initialiseSchema(name: String) {
    
    let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    let realmFileURL = docDir.appendingPathComponent("\(name).realm")
    
    let config = Realm.Configuration(fileURL: realmFileURL, schemaVersion: 1) { migration, oldSchemaVersion in
      if oldSchemaVersion < 1 {
        migration.enumerateObjects(ofType: Country.className()) { _, newObject in
          newObject!["flag"] = "🏳"
        }
      }
    }
    
    Realm.Configuration.defaultConfiguration = config
    
    print(docDir.path)
    
    do {
      realm = try Realm()
    } catch {
      print("Error opening default realm", error)
    }
  }
  
  func add(country: Country) {
    if let realm = realm {
      do {
        try realm.write({
          realm.add(country)
        })
      } catch {
        print("Error adding country to realm", error)
      }
    }
  }
  
  /// deletes a country
  func remove(country: Country) {
    if let realm = realm {
      if let countryToDelete = realm.object(ofType: Country.self, forPrimaryKey: country.id) {
        
        do {
          try realm.write({
            realm.delete(countryToDelete)
          })
        } catch {
          print("Error deleting the object", error)
        }
        
      }
    }
  }
  
  func deleteCities(for country: Country) {
    if let realm = realm {
      do {
        try realm.write({
          realm.delete(country.cities)
        })
      } catch {
        print("Error deleting the cities", error)
      }
    }
  }
}
