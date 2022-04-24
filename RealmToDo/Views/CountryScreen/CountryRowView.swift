//
//  CountryRowView.swift
//  RealmToDo
//
//  Created by Aybars Acar on 24/4/2022.
//

import SwiftUI
import RealmSwift

struct CountryRowView: View {
  
  @ObservedRealmObject var country: Country
  
  @FocusState var isFocused: Bool?
  
  @State private var showFlagPicker = false
  
  var body: some View {
    HStack {
      
      Button {
        showFlagPicker = true
      } label: {
        Text(country.flag)
      }
      .buttonStyle(.plain)

      
      TextField("New Country", text: $country.name)
        .focused($isFocused, equals: true)
        .textFieldStyle(.roundedBorder)
        .padding()
        .frame(height: 30)
      
      Spacer()
      
      Text("\(country.cities.count) cities")
        .font(.caption)
    }
    .sheet(isPresented: $showFlagPicker) {
      FlagPicker(country: country)
    }
  }
}

struct CountryRowView_Previews: PreviewProvider {
  static var previews: some View {
    CountryRowView(country: Country(name: "Australia"))
  }
}
