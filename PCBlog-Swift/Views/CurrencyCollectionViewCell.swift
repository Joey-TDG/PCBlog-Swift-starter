import UIKit

class CurrencyCollectionViewCell: UICollectionViewCell {
    // Define the image view and label
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    
    // Override the initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        configureCellAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    private func configureCellAppearance() {
        // Set background color to white
        contentView.backgroundColor = UIColor.white
        

        // Apply gray border
         contentView.layer.borderWidth = 1.0
         contentView.layer.borderColor = UIColor.gray.cgColor
    }
    
    // MARK: - View Setup
    
    // Setup the views and constraints
    private func setupViews() {
        // Add the image view
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.CurrencyCollectionViewCell.Sizes.imageHeight)
        ])
        
        // Add the label
        contentView.addSubview(label)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical) // Lower priority for vertical compression
        label.setContentCompressionResistancePriority(.required, for: .vertical) // Higher priority for vertical expansion
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.CurrencyCollectionViewCell.Sizes.labelTopPadding),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.CurrencyCollectionViewCell.Sizes.labelLeadingPadding),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.CurrencyCollectionViewCell.Sizes.labelTrailingPadding),
            label.heightAnchor.constraint(equalToConstant: Constants.CurrencyCollectionViewCell.Sizes.labelHeight),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Cell Configuration
    
    // Configure the cell with an image URL and text
//    func configure(with imageURL: URL, text: NSAttributedString, color: UIColor) {
//        // Fetch image data from URL
//        DispatchQueue.global().async { [weak self] in
//            if let imageData = try? Data(contentsOf: imageURL),
//               let image = UIImage(data: imageData) {
//                // Update UI on the main thread
//                DispatchQueue.main.async {
//                    self?.imageView.image = image
//                }
//            }
//        }
//        contentView.backgroundColor = color
//        label.attributedText = text
//    }
    
    func configure(with imageURL: URL, text: NSAttributedString, color: UIColor) {
        // Use the ImageDownloadService to download the image from the URL
        let imageDownloadService = ImageDownloadService()
        imageDownloadService.downloadFromURL(url: imageURL.absoluteString, success: { [weak self] image in
            // Update the UI on the main thread with the downloaded image
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }, failure: { errorText in
            print(errorText)
        })
        
        contentView.backgroundColor = color
        label.attributedText = text
    }
}
