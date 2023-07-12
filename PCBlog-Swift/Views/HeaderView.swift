import UIKit

class HeaderView: UICollectionReusableView {
    // MARK: - Properties
    
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
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        configureAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    private func configureAppearance() {
        // Set background color to black
        backgroundColor = UIColor.customGray
        
        // Apply rounded corners
        layer.cornerRadius = Constants.Dimensions.cornerRadius
        layer.masksToBounds = true
    }
    
    // MARK: - View Setup
    
    private func setupViews() {
        // Add the image view
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.HeaderView.Sizes.imageHeight)
        ])
        
        // Add the label
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.HeaderView.Sizes.labelTopPadding), // Set the vertical spacing between the image view and label
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: Constants.HeaderView.Sizes.labelHeight),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Public Methods
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
    
    func configureLabel(with attributedText: NSAttributedString) {
        label.attributedText = attributedText
    }
}
