//
//  ContentView.swift
//  UserPreferences
//
//  Created by Chiune Honda - 895 on 2025-04-15.
//

import SwiftUI

struct ContentView: View {
    // ApppStorage propertites
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @AppStorage("username") private var username: String = ""
    @AppStorage("favoriteColor") private var favoriteColor: String = "Blue"
    //Personal @AppStorage Implementation
    @AppStorage("birthYear") private var birthYear: String = ""
    
    private let colors = ["Red", "Green", "Blue", "Yellow", "Purple"]
    
    
    var body: some View {
        
        NavigationView {
            
            Form {
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                }
                Section(header: Text("User Info")) {
                    TextField("Enter your name", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Enter Your Birth Year", text: $birthYear)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                Section(header: Text("Preferences")) {
                    Picker("Favorite Color", selection: $favoriteColor) {
                        ForEach(colors, id: \.self) { color in
                            Text(color).tag(color)
                        }}}
                   
                        Section(header: Text("Saved Preferences")){
                            Text("Dark Mode: \(isDarkMode ? "Enabled" : "Disabled")")
                            Text("Username: \(username.isEmpty ? "Not Set" : username)")
                            Text("Favorite Color:\(favoriteColor)")
                            Text("Birth Year: \(birthYear)")
                 }
                
                
                
            }
            
            
            .navigationTitle("User Preferences")
            
            
        }
        
        
    }
}
