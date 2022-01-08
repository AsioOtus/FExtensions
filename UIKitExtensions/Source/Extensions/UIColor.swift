import UIKit

extension UIColor {
    var rgb: (red: Double, green: Double, blue: Double, alpha: Double) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var alpha: CGFloat = 0
        
        guard getRed(&r, green: &g, blue: &b, alpha: &alpha) else { return (0, 0, 0, 0) }
        
        return (r, g, b, alpha)
    }
    
    var redComponent: Double { rgb.red }
    var greenComponent: Double { rgb.green }
    var blueComponent: Double { rgb.blue }
    
    var alpha: Double { rgb.alpha }
    
    func new (red: Double? = nil, green: Double? = nil, blue: Double? = nil, alpha: Double? = nil) -> Self {
        .init(red: red ?? rgb.red, green: green ?? rgb.green, blue: blue ?? rgb.blue, alpha: alpha ?? rgb.alpha)
    }
    
    func newRGB (alpha: Double) -> Self { new(red: nil, green: nil, blue: nil, alpha: alpha) }
    
    func new (alpha: Double) -> Self { new(red: nil, green: nil, blue: nil, alpha: alpha) }
}

extension UIColor {
    var hsb: (hue: Double, saturation: Double, brightness: Double, alpha: Double) {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        guard getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) else { return (0, 0, 0, 0) }
        
        return (hue, saturation, brightness, alpha)
    }
    
    var hue: Double { hsb.hue }
    var saturation: Double { hsb.saturation }
    var brightness: Double { hsb.brightness }
    
    func new (hue: Double? = nil, saturation: Double? = nil, brightness: Double? = nil, alpha: Double? = nil) -> Self {
        .init(hue: hue ?? hsb.hue, saturation: saturation ?? hsb.saturation, brightness: brightness ?? hsb.brightness, alpha: alpha ?? hsb.alpha)
    }
    
    func newHSB (alpha: Double) -> Self { new(hue: nil, saturation: nil, brightness: nil, alpha: alpha) }
}

extension UIColor {
    var grayscale: (white: Double, alpha: Double) {
        var white: CGFloat = 0
        var alpha: CGFloat = 0
        
        guard getWhite(&white, alpha: &alpha) else { return (0, 0) }
        
        return (white, alpha)
    }
    
    var whiteComponent: Double { grayscale.white }
    
    func new (white: Double? = nil, alpha: Double? = nil) -> Self {
        .init(white: white ?? grayscale.white, alpha: alpha ?? grayscale.alpha)
    }
    
    func newGrayscale (alpha: Double) -> Self { new(white: nil, alpha: alpha) }
}

extension UIColor {
	convenience init (hex: Int, alpha: CGFloat = 1) {
		let red = CGFloat((hex & 0xff0000) >> 16) / 255
		let green = CGFloat((hex & 0x00ff00) >> 8) / 255
		let blue = CGFloat(hex & 0x0000ff) / 255
		
		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}
}
