//
//  ContentView.swift
//  lesson 402
//
//  Created by Garib Agaev on 17.09.2023.
//

import SwiftUI

struct ContentView: View {
    static private let redValue = Double.random(in: 0...255)
    static private let greenValue = Double.random(in: 0...255)
    static private let blueValue = Double.random(in: 0...255)
        
    @State private var redValue = redValue
    @State private var greenValue = greenValue
    @State private var blueValue = blueValue
    
    @State private var redText = "\(lround(redValue))"
    @State private var greenText = "\(lround(greenValue))"
    @State private var blueText = "\(lround(blueValue))"
    
    var body: some View {
        ZStack {
            Color(.blue)
                .ignoresSafeArea()
            VStack {
                ColorView(redValue: redValue, greenValue: greenValue, blueValue: blueValue)
                ColorSlider(colorValue: $redValue, colorText: $redText, color: .red)
                ColorSlider(colorValue: $greenValue, colorText: $greenText, color: .green)
                ColorSlider(colorValue: $blueValue, colorText: $blueText, color: .blue)
                Spacer()
            }
            .padding()
        }.toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Done") {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColorSlider: View {
    @Binding var colorValue: Double
    @Binding var colorText: String
    @State private var alertFlag = false
    let color: Color
    
    var body: some View {
        HStack {
            Text("\(lround(colorValue))")
                .frame(width: 50)
            Slider(value: Binding(get: {colorValue}, set: setd), in: 0...255, step: 1)
                .accentColor(color)
            TextField("", text: Binding(get: {colorText}, set: sett))
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
                .frame(width: 50)
                .alert("Wrong Format", isPresented: $alertFlag, actions: {}) {
                    Text("Please enter valve from 0 to 255")
                }
        }
    }
    
    private func setd(_ newValue: Double) {
        colorValue = newValue
        colorText = "\(lround(colorValue))"
    }
    
    private func sett(_ newValue: String) {
        if newValue == "" {
            colorValue = 0
        } else if let number = Double(newValue), 0 <= number && number <= 255 {
            colorValue = number
        } else {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            alertFlag = true
        }
        colorText = ""
        colorText = "\(lround(colorValue))"
    }
}

struct ColorView: View {
    var redValue: Double
    var greenValue: Double
    var blueValue: Double
    
    var body: some View {
        Color(red: redValue / 256, green: greenValue / 256, blue: blueValue / 256)
            .frame(height: 150)
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 3)
                .foregroundColor(.white)
            )
    }
}
