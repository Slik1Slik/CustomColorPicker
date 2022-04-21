//
//  ContentView.swift
//  CustomColorPicker
//
//  Created by Slik on 14.04.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var color: Color = .red
    @State private var isColorToBeSelected: Bool = false
    var body: some View {
        VStack {
            color
                .frame(maxWidth: .infinity, maxHeight: 200)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(
                    Text("Hi")
                        .font(.largeTitle)
                        .foregroundColor(color.isDark && !color.isTransparent ? .white : .black)
                )
            Button(isColorToBeSelected ? "Done" : "Select color") {
                withAnimation {
                    isColorToBeSelected.toggle()
                }
            }
            if isColorToBeSelected {
                CustomColorPicker(selection: $color)
                    .padding()
                    .background(
                        Color.secondary.opacity(0.1)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    )
                    .transition(.move(edge: .bottom))
                    .padding()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
