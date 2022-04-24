//
//  CountryListView.swift
//  RealmToDo
//
//  Created by Aybars Acar on 24/4/2022.
//

import SwiftUI
import RealmSwift

struct CountryListView: View {

  @EnvironmentObject var realmManager: RealmManager
  
  @FocusState private var isFocused: Bool?
  
  var body: some View {
    NavigationView {
      VStack {
        
        if let countries = realmManager.searchResults {
          if countries.isEmpty {
            Text("Tap on the \(Image(systemName: "plus.circle.fill")) button above to create a new Country.")
          }
          else {
            List {
              ForEach(countries.sorted { $0.name < $1.name }) { country in
                
                if !country.isInvalidated {
                  NavigationLink {
                    CitiesListView(country: country)
                  } label: {
                    CountryRowView(country: country, isFocused: _isFocused)
                  }
                }
           
              }
              .onDelete { indexSet in
                deleteCountry(indexSet: indexSet)
              }
              .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .searchable(text: $realmManager.searchFilter, placement: .navigationBarDrawer(displayMode: .always)) {
              ForEach(countries) { country in
                Text(country.name)
                  .searchCompletion(country.name)
              }
            }
          }
        }
        
        Spacer()
      }
      .animation(.easeIn, value: realmManager.countries)
      .navigationBarTitle("Countries")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            realmManager.add(country: Country())
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
  }
}

// MARK: - Methods
extension CountryListView {
  
  /// deletes a country based on the indexset on a given sorted array
  /// delete on cascade
  private func deleteCountry(indexSet: IndexSet) {
    guard let index = indexSet.first else { return }
    
    let selectedCountry = realmManager.countriesArray.sorted { $0.name < $1.name }[index]
    
    realmManager.deleteCities(for: selectedCountry)
    realmManager.remove(country: selectedCountry)
  }
}

struct CountryListView_Previews: PreviewProvider {
  static var previews: some View {
    CountryListView()
      .environmentObject(RealmManager(name: "sample"))
  }
}
