//
//  RealmToDoApp.swift
//  RealmToDo
//
//  Created by Aybars Acar on 23/4/2022.
//

import SwiftUI

@main
struct RealmToDoApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .onAppear {
          print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
          
          // suppress NavigationView warnings
          UserDefaults.standard.setValue(false, forKeyPath: "_UIConstraintBasedLayoutLogUnsatisfiable")
        }
    }
  }
}
