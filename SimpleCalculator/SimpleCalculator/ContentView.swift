//
//  ContentView.swift
//  SimpleCalculator
//
//  Created by Chiune Honda - 895 on 2025-02-18.
//

import SwiftUI
struct ContentView: View {
  @State private var numberOne: Int = 0
  @State private var numberTwo: Int = 0
  @State private var result: Int = 0
  func calculateSum()
  {
    result = numberOne + numberTwo
  }
  var body: some View {
    VStack {
     // textfield
     // stores and views #1 var
     TextField("enter first number", value: $numberOne, format: .number)
      .textFieldStyle(.roundedBorder)
      .padding()
      .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
     // text field
     // stores and views var #2
     TextField("enter second number", value: $numberTwo, format: .number)
      .textFieldStyle(.roundedBorder)
      .padding()
      .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
     // button
     // calculates the sum
     Button(action: calculateSum) {
      Text("Calculate Sum").padding()
       .background(.blue)
       .foregroundColor(.white)
       .cornerRadius(20)
     }
     // text
     // shows the result
     Text("Result: \(result)")
      .font(.title)
    }
    .padding()
   }
  }
  #Preview {
   ContentView()
  }
