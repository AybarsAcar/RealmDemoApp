//
//  CountryListView.swift
//  RealmToDo
//
//  Created by Aybars Acar on 24/4/2022.
//

import SwiftUI
import RealmSwift

struct CountryListView: View {
  
  @ObservedResults(Country.self) var countries
  
  @FocusState private var isFocused: Bool?
  
  @State private var presentAlert = false
  
  var body: some View {
    NavigationView {
      VStack {
        if countries.isEmpty {
          Text("Tap on the \(Image(systemName: "plus.circle.fill")) button above to create a new Country.")
        }
        else {
          List {
            ForEach(countries.sorted(byKeyPath: "name")) { country in
              NavigationLink {
                CitiesListView(country: country)
              } label: {
                CountryRowView(country: country, isFocused: _isFocused)
              }
            }
            .onDelete { indexSet in
              deleteCountry(indexSet: indexSet)
            }
            .listRowSeparator(.hidden)
          }
          .listStyle(.plain)
        }
        
        Spacer()
      }
      .animation(.easeIn, value: countries)
      .navigationBarTitle("Countries")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            $countries.append(Country())
          } label: {
            Image(systemName: "plus.circle.fill")
              .font(.title2)
          }
          
        }
        
        ToolbarItemGroup(placement: .keyboard) {
          HStack {
            Spacer()
            Button {
              isFocused = nil
            } label: {
              Image(systemName: "keyboard.chevron.compact.down")
            }
          }
        }
      }
    }
    .alert("You must first delete all of the cities in the country", isPresented: $presentAlert) {
    }
  }
}

// MARK: - Methods
extension CountryListView {
  
  /// deletes a country based on the indexset on a given sorted array
  /// deletes only if there are no cities in the country
  private func deleteCountry(indexSet: IndexSet) {
    guard let index = indexSet.first else { return }
    
    let selectedCountry = Array(countries.sorted(byKeyPath: "name"))[index]
    
    guard selectedCountry.cities.isEmpty else {
      presentAlert.toggle()
      return
    }
    
    $countries.remove(selectedCountry)
  }
}

struct CountryListView_Previews: PreviewProvider {
  static var previews: some View {
    CountryListView()
  }
}
