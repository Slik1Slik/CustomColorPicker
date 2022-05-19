# CustomColorPicker
SwiftUI-based color picker.

## Description
No doubts that the original UIColorPicker, and it's SwiftUI view representation, is a great and powerful control. But unfortunately, it can be presented only as a page sheet, which may not be in handy if you have a screen with multiple color parameters needed to be set.

CustomColorPicker is a moveable variation of the default ColorPicker view, and it can be placed anywhere you want and whatever presentation style you prefer.

## Features
  - Picking and customizing color by changing it's parameters;
  - Supports brightness and opacity;
  - Saving and managing recent picked colors throughout the control's life-cycle.

## Using in app
Use the control as well as any other view.

```swift
struct ColorThemeDetails: View {

    @State private var color: Color = .blue
    
    var body: some View {
         CustomColorPicker(selection: $color,
                        minBrightness: 0.3,
                        minHSBAUnit: 0.01,
                        pickerStyle: .carousel,
                        colorLabelBackground: .gradient)
    }
}
```

## Preview
<img src="https://user-images.githubusercontent.com/71648669/169195787-b8a5791a-17cf-4b6f-ad26-72133b3fa41a.jpg" width="300" height="240">

## FAQ
The repo also contains some UIColor and CGColor extensions and new types related to working with colors, which may be helpful in other projects as well.
