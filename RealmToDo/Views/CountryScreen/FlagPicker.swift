//
//  FlagPicker.swift
//  RealmToDo
//
//  Created by Aybars Acar on 24/4/2022.
//

import SwiftUI
import RealmSwift

struct FlagPicker: View {
  
  @Environment(\.dismiss) private var dismiss
  
  @ObservedRealmObject var country: Country
  
  @State private var searchText = ""
  
  var searchResults: [CountryInfo] {
    if searchText.isEmpty {
      return CountryInfo.array
    }
    else {
      return CountryInfo.array.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
  }
  
  var body: some View {
    NavigationView {
      List {
        ForEach(searchResults) { countryInfo in
          Button {
            $country.flag.wrappedValue = countryInfo.flag
            dismiss()
          } label: {
            HStack {
              Text("\(countryInfo.name) \(countryInfo.flag)")
              
              Spacer()
              
              if country.flag == countryInfo.flag {
                Image(systemName: "checkmark")
              }
            }
          }
          
        }
      }
      .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
      .navigationTitle("Flag")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            dismiss()
          } label: {
            Image(systemName: "x.circle")
          }
          
        }
      }
    }
  }
}

struct FlagPicker_Previews: PreviewProvider {
  static var previews: some View {
    FlagPicker(country: Country(name: "Australia"))
  }
}
