//
//  ContentView.swift
//  RealmToDo
//
//  Created by Aybars Acar on 24/4/2022.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      ToDoListView()
        .tabItem {
          Image(systemName: "square.and.pencil")
          Text("ToDo")
        }
      
      CountryListView()
        .tabItem {
          Image(systemName: "globe.asia.australia")
          Text("Countries")
        }
      
      AllCitiesView()
        .tabItem {
          Image(systemName: "building.2.crop.circle")
          Text("All Cities")
        }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
