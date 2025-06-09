//
//  ContentView.swift
//  ProfileCard
//
//  Created by Chiune Honda - 895 on 2025-01-31.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack{
            Color.black
        }
        
        
        
        VStack {
            Image("Tyler the creator PFP")
                .resizable()
                .scaledToFit()
                .frame(width:150, height:150)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 4))
                .shadow(radius:15)
            
            
            Text("CHIUNE HONDA")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(Color.primary)
                .padding()
                .background(Color
                    . white, in:
                RoundedRectangle(cornerRadius: 8))
                .padding()
            Text("Better than Tyler 'comickal' Liaw at Fortnite")
                .font(.headline)
                .foregroundStyle(Color.white)
                .foregroundColor(.secondary)
 
            
            
        }
        .padding()
        .background(Color.black)
        Color.black
        
    }
}

#Preview {
    ContentView()
}
