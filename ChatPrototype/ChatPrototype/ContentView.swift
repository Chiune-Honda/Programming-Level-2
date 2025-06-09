//
//  ContentView.swift
//  ChatPrototype
//
//  Created by Chiune Honda - 895 on 2025-01-29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Knock Knock")
                .padding()
                .background(Color
                    . yellow, in:
                RoundedRectangle(cornerRadius: 8))
   
            Text("Who's there")
                .padding()
                .background(Color
                    . green, in:
                RoundedRectangle(cornerRadius: 8))
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

