//
//  RealmToDoApp.swift
//  RealmToDo
//
//  Created by Aybars Acar on 23/4/2022.
//

import SwiftUI

@main
struct RealmToDoApp: App {
  
  @StateObject private var manager = RealmManager(name: "example3")
  
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(manager)
        .onAppear {
          // suppress NavigationView warnings
          UserDefaults.standard.setValue(false, forKeyPath: "_UIConstraintBasedLayoutLogUnsatisfiable")
        }
    }
  }
}
