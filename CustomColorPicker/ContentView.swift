//
//  ContentView.swift
//  CustomColorPicker
//
//  Created by Slik on 14.04.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var color = Color.red
    var body: some View {
        //ColorPicker("", selection: $color)
        CustomColorPicker(selection: $color, pickerStyle: .grid, colorLabelBackground: .gradient)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
