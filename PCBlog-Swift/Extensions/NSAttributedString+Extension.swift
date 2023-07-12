import UIKit

extension NSAttributedString {
    /// Creates a clean attributed string with the specified text, font, and text color.
        ///
        /// - Parameters:
        ///   - text: The plain text for the attributed string.
        ///   - font: The font to be applied to the attributed string.
        ///   - textColor: The color of the text in the attributed string.
        /// - Returns: An attributed string with the specified text, font, and text color.
    static func cleanAttributedString(text: String, font: UIFont, textColor: UIColor) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: textColor
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    // Converts HTML text to an attributed string with the specified font and text color
       static func cleanAttributedString(html: String, font: UIFont, textColor: UIColor) -> NSAttributedString? {
           guard let data = html.data(using: .utf8) else {
               return nil
           }
           
           // Define options for HTML parsing
           let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
               .documentType: NSAttributedString.DocumentType.html,
               .characterEncoding: String.Encoding.utf8.rawValue
           ]
           
           do {
               // Parse HTML and create an attributed string
               let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
               
               // Apply font and text color to the attributed string
               let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
               mutableAttributedString.addAttributes([
                   .font: font,
                   .foregroundColor: textColor
               ], range: NSRange(location: 0, length: mutableAttributedString.length))
               
               return mutableAttributedString
           } catch {
               print("Failed to parse HTML: \(error)")
               return nil
           }
       }
}
