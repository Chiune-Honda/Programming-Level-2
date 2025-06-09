//
//  ContentView.swift
//  WeatherReportApp
//
//  Created by Chiune Honda - 895 on 2025-02-26.
//

import SwiftUI

struct ContentView: View {
    @State private var temperature: String = "20"
    @State private var weatherMessage: String = ""
    
    var body: some View {
        VStack {

            TextField("Enter temperature in Celsius" , text: $temperature)
                .padding()
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)

            Button(action: {
                if Int(temperature)! < 0 {
                    weatherMessage = "It's freezing!"
                }
                else if Int(temperature)! < 15 {
                    weatherMessage = "It's cold!"
                }
                else if Int(temperature)! >= 20 && Int(temperature)! <= 25 {
                    weatherMessage = "It's warm!"
                }
                else {
                    weatherMessage = "It's hot out!"
                }
            })
            {
                Text("Check weather")
                    .font(.title)
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    }

            Text(weatherMessage)
                .font(.title2)
                .padding()
                }
        .padding()
    }
}

#Preview {
    ContentView()
}
