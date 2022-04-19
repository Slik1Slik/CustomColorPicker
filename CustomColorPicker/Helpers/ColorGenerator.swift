//
//  ColorGenerator.swift
//  CustomColorPicker
//
//  Created by Slik on 14.04.2022.
//

import SwiftUI

class ColorGenerator {
    static func generateColors(_ components: RGBAComponents,
                               rIncrement: CGFloat = 0,
                               gIncrement: CGFloat = 0,
                               bIncrement: CGFloat = 0,
                               count: Int = 1) -> [Color]
    {
        var rValue = components.red
        var gValue = components.green
        var bValue = components.blue
        
        var resultArray = [Color(red: rValue, green: gValue, blue: bValue)]
        
        for _ in 0..<count {
            rValue += rIncrement
            gValue += gIncrement
            bValue += bIncrement
            
            resultArray.append(Color(red: rValue, green: gValue, blue: bValue))
        }
        
        return resultArray
    }
}

/*
 
 //
 //  CustomColorPicker.swift
 //  CustomColorPicker
 //
 //  Created by Slik on 14.04.2022.
 //

 import SwiftUI

 struct CustomColorPicker: View {
     
     @State var selectedColor: Color = .init(red: 1, green: 0, blue: 0)
     
     @State var brightness: Double = 0.0
     
     var body: some View {
         VStack {
             ScrollView(.horizontal, showsIndicators: false) {
                 HStack(spacing: 3) {
                     ForEach(colors, id: \.self) { color in
                         color.clipShape(Circle())
                             .frame(width: 40, height: 40)
                             .background(Circle().stroke(.black, lineWidth: selectedColor == color ? 1 : 0))
                             .onTapGesture {
                                 selectedColor = color
                                 brightness = 0
                             }
                     }
                 }
                 .padding()
             }
             Slider(value: $brightness, in: 0...1, step: 1/255)
                 .padding()
         }
         .onChange(of: brightness) { newValue in
             let uiColor = UIColor(selectedColor)
             let hsv = uiColor.hsv()
             selectedColor = Color(UIColor(hue: hsv.0/360, saturation: hsv.1, brightness: hsv.2, alpha: 0).cgColor)
             print(hsv.2)
         }
         .background(selectedColor.edgesIgnoringSafeArea(.all))
     }
     
     private var colors: [Color] = [
         .init(red: 1, green: 0, blue: 0),     //red
         .init(red: 1, green: 128/255, blue: 0),   //orange
         .init(red: 1, green: 1, blue: 0),   //yellow
         .init(red: 0, green: 1, blue: 0),     //green
         .init(red: 0, green: 1, blue: 1),   //turquoise
         .init(red: 0, green: 128/255, blue: 1),   //skyBlue
         .init(red: 0, green: 0, blue: 1),     //blue
         .init(red: 127/255, green: 0, blue: 1),   //violet
         .init(red: 1, green: 0, blue: 1),   //fuchsia
         .init(red: 1, green: 0, blue: 127/255),   //pink
         .init(red: 128/255, green: 128/255, blue: 128/255)  //gray
     ]
 }

 struct CustomColorPicker_Previews: PreviewProvider {
     static var previews: some View {
         CustomColorPicker()
     }
 }

 extension UIColor {
     
     public func adjust(hueBy hue: CGFloat = 0, saturationBy saturation: CGFloat = 0, brightnessBy brightness: CGFloat = 0) -> UIColor {
         
         var currentHue: CGFloat = 0.0
         var currentSaturation: CGFloat = 0.0
         var currentBrigthness: CGFloat = 0.0
         var currentAlpha: CGFloat = 0.0
         
         if getHue(&currentHue, saturation: &currentSaturation, brightness: &currentBrigthness, alpha: &currentAlpha) {
             return UIColor(hue: currentHue + hue,
                            saturation: currentSaturation + saturation,
                            brightness: currentBrigthness + brightness,
                            alpha: currentAlpha)
         } else {
             return self
         }
     }
     
     public func colorWithBrightness(brightness: CGFloat) -> UIColor {
         var H: CGFloat = 0, S: CGFloat = 0, B: CGFloat = 0, A: CGFloat = 0
         
         if getHue(&H, saturation: &S, brightness: &B, alpha: &A) {
             B += (brightness - 1.0)
             B = max(min(B, 1.0), 0.0)
             
             return UIColor(hue: H, saturation: S, brightness: B, alpha: A)
         }
         
         return self
     }
     
     func hsv() -> (CGFloat, CGFloat, CGFloat) {
         let cgColor = self.cgColor
         
         let r: CGFloat = cgColor.components?[0] ?? 0
         let g: CGFloat = cgColor.components?[1] ?? 0
         let b: CGFloat = cgColor.components?[2] ?? 0
         
         let max: CGFloat = max(r, g, b)
         let min: CGFloat = min(r, g, b)
         
         var hue: CGFloat = 0
         
         if max == min {
             hue = 0.0
         }else if max == r && g >= b {
             hue = 60 * (g-b)/(max-min)
         } else if max == r && g < b {
             hue = 60 * (g-b)/(max-min) + 360
         } else if max == g {
             hue = 60 * (b-r)/(max-min) + 120
         } else if max == b {
             hue = 60 * (r-g)/(max-min) + 240
         }
         
         var saturation: CGFloat = 0
         if max == 0 {
             saturation = 0
         } else {
             saturation = (max - min)/max
         }
         
         let value: CGFloat = max
         
         return (hue, saturation, value)
     }
 }

 //
 //  CustomColorPicker.swift
 //  CustomColorPicker
 //
 //  Created by Slik on 14.04.2022.
 //

 import SwiftUI

 struct CustomColorPicker: View {
     
     @State var selectedColor: Color = .blue
     
     private var rows: [GridItem] = [
         GridItem(.fixed(30), spacing: 1),
         GridItem(.fixed(30), spacing: 1),
         GridItem(.fixed(30), spacing: 1),
         GridItem(.fixed(30), spacing: 1),
         GridItem(.fixed(30), spacing: 1),
     ]
     
     private var colors: [Color] = []
     
     var body: some View {
         LazyHGrid(rows: rows, spacing: 1) {
             ForEach(0..<colors.count) { index in
                 colors[index]
             }
         }
     }
     
     private func getColors() -> [Color] {
         var resultArray: [Color] = []
         
         for index in 0..<rgbComponents.count {
             resultArray.append(contentsOf: ColorGenerator.generateColors(rgbComponents[index],
                                                                          rIncrement: increments[index].0,
                                                                          gIncrement: increments[index].1,
                                                                          bIncrement: increments[index].2,
                                                                          count: 4))
         }
         return resultArray
     }
     
     private var rgbComponents: [RGBComponents] = [
         .init(red: 255, green: 0, blue: 0),     //red
         .init(red: 255, green: 128, blue: 0),   //orange
         .init(red: 255, green: 255, blue: 0),   //yellow
         .init(red: 0, green: 255, blue: 0),     //green
         .init(red: 0, green: 255, blue: 255),   //turquoise
         .init(red: 0, green: 128, blue: 255),   //skyBlue
         .init(red: 0, green: 0, blue: 255),     //blue
         .init(red: 127, green: 0, blue: 255),   //violet
         .init(red: 255, green: 0, blue: 255),   //fuchsia
         .init(red: 255, green: 0, blue: 127),   //pink
         .init(red: 128, green: 128, blue: 128)  //gray
     ]
     
     private var increments: [(Double, Double, Double)] = [
         (0, 51, 51), //red
         (0, 25, 51), //orange
         (0, 0, 51),  //yellow
         (51, 0, 51), //green
         (51, 0, 0),  //turquoise
         (51, 25, 0), //skyBlue
         (51, 51, 0), //blue
         (25, 51, 0), //violet
         (0, 51, 0),  //fuchsia
         (0, 51, 25), //pink
         (32, 32, 32) //gray
     ]
     
     init() {
         self.colors = getColors()
     }
 }

 struct CustomColorPicker_Previews: PreviewProvider {
     static var previews: some View {
         CustomColorPicker()
     }
 }

 
 */
