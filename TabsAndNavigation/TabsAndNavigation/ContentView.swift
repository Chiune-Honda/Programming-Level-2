//
//  ContentView.swift
//  TabsAndNavigation
//
//  Created by Chiune Honda - 895 on 2025-04-16.
//

import SwiftUI

struct ContentView: View {

    var body: some View {

        TabView {

            HomeView()

                .tabItem {

                    Label("Home", systemImage: "house")

                }

            SettingsView()

                .tabItem {
                    
                    Label("Settings", systemImage: "gear")
                }
            
            BalanceView()
                        .tabItem {
                    Label("Balance", systemImage: "lock")
                        }
}}}

    struct HomeView: View {

        var body: some View {

            NavigationStack {
                
                List {
                    
                    NavigationLink(destination: DetailView(title: "Item 1")) {
                        
                        Text("Go to Item 1")
                        
                    }
                    
                    NavigationLink(destination: DetailView(title: "Item 2")) {
                        
                        Text("Go to Item 2")
                        
                    }
                    
                }
                
                .navigationTitle("Home")
}}}

    struct DetailView: View {

        let title: String

        var body: some View {

            Text("Details for \(title)")

                .font(.largeTitle)

                .padding()
}}

struct SettingsView: View {

        var body: some View {
            VStack {

                Text("Settings")

                    .font(.largeTitle)

                    .padding()

                Toggle("Enable Notifications", isOn: .constant(true))

                    .padding()}
            .navigationTitle("Settings")
}}

struct BalanceView: View {
    var body: some View {
        
        
        NavigationStack {
            
            List {
                
                NavigationLink(destination: DetailView(title: "Chequing Account")) {
                    
                    Text("Chequing Account")
                    
                }
                
                NavigationLink(destination: DetailView(title: "Saving Account")) {
                    
                    Text("Saving Account")
                    
                }
                
            }
            
            .navigationTitle("Balance")
            
        }
    }
    
    
    
}
