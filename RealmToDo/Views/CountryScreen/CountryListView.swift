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
  }
}

struct CountryListView_Previews: PreviewProvider {
  static var previews: some View {
    CountryListView()
  }
}
