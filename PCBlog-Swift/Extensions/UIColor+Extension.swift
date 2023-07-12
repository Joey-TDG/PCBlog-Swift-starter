import UIKit

extension UIColor {
    // Custom color: Custom Gray
    static var customGray: UIColor {
        return UIColor.fromHex("#1A191A") ?? UIColor.gray
    }
    
    // Convert a hexadecimal color string to a UIColor
    static func fromHex(_ hex: String, alpha: CGFloat = 1.0) -> UIColor? {
        let scanner = Scanner(string: hex.replacingOccurrences(of: "#", with: ""))
        var rgbValue: UInt64 = 0
        
        guard scanner.scanHexInt64(&rgbValue) else {
            return nil
        }
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
