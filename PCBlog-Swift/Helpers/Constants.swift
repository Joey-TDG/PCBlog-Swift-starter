import UIKit

// MARK: - Constants

struct Constants {
    
    // MARK: - HeaderView Constants
    
    struct HeaderView {
        struct Sizes {
            static let labelTopPadding: CGFloat = 8 // Top padding for label in HeaderView
            static let imageHeight: CGFloat = 180 // Height of the image in HeaderView
            static let labelHeight: CGFloat = 100 // Height of the label in HeaderView
        }
    }
    
    // MARK: - Identifier Constants
    struct Identifier {
         static let subclassedCell = "subclassedcell"
         static let headerView = "HeaderView"
     }
    
    // MARK: - Dimensions Constants
    
    struct Dimensions {
        static let cornerRadius: CGFloat = 10 // Corner radius for rounded corners
    }
    
    // MARK: - SubclassedCollectionViewCell Constants
    
    struct CurrencyCollectionViewCell {
        struct Sizes {
            static let imageHeight: CGFloat = 80 // Height of the image in SubclassedCollectionViewCell
            static let labelTopPadding: CGFloat = 5 // Top padding for label in SubclassedCollectionViewCell
            static let labelHeight: CGFloat = 60 // Height of the label in SubclassedCollectionViewCell
            static let labelLeadingPadding: CGFloat = 10 // Leading padding for label in SubclassedCollectionViewCell
            static let labelTrailingPadding: CGFloat = 10 // Trailing padding for label in SubclassedCollectionViewCell
        }
    }
    
    // MARK: - TransparentWebAlertViewController Constants
        
        struct TransparentWebAlertViewController {
            struct Sizes {
                static let containerViewPadding: CGFloat = 20 // Padding from each side for the containerView
                static let titleLabelHeight: CGFloat = 40 // Height of the titleLabel
                static let closeButtonSize: CGFloat = 40 // Width and height of the closeButton
            }
        }
}
