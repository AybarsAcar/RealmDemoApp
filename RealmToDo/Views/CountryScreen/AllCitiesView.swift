//
//  AllCitiesView.swift
//  RealmToDo
//
//  Created by Aybars Acar on 24/4/2022.
//

import SwiftUI
import RealmSwift

struct AllCitiesView: View {
  
  @ObservedResults(City.self, sortDescriptor: SortDescriptor(keyPath: "name")) var cities
  
  var body: some View {
    NavigationView {
      List {
        ForEach(cities) { city in
          HStack {
            Text(city.name)
            Spacer()
            Text(city.country.first?.name ?? "N/A")
          }
        }
        .onDelete(perform: $cities.remove)
      }
      .navigationBarTitle("All Cities")
    }
  }
}

struct AllCitiesView_Previews: PreviewProvider {
  static var previews: some View {
    AllCitiesView()
  }
}
