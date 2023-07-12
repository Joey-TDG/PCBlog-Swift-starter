//
//  ViewController.swift
//  PCBlog-Swift
//
//  Created by Hoan Tran on 8/22/22.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var currenyViewModel = CurrencyViewModel()
    private var collectionView: UICollectionView!
    private lazy var feed: Feed  = Feed(title: "", items:[Item(id: "", title: "", summary: "", url: "", content_html: "", author: ["":""], date_published: "", featured_image: "")]) {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let floatingTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "The Currency"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.backgroundColor = UIColor.customGray
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the collection view
        setupFloatingTitleLabel()
        setupLayout(with: view.bounds.size)
        setupCollectionView()
        setupViewModelAndFetchFeed()
    }
    
    func setupViewModelAndFetchFeed() {
        currenyViewModel.delegate = self
        currenyViewModel.fetchFeed()
    }
    
    // MARK: - Collection View Setup
    
    func setupCollectionView() {
        // Set the data source
        collectionView.dataSource = self
        // Set the delegate
        collectionView.delegate = self
        // Enable bouncing at the bottom of the collection view
        collectionView.alwaysBounceVertical = true
        // Set the background color to white
        collectionView.backgroundColor = UIColor.customGray
        
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.Identifier.headerView)
    }
    
    
    /// Sets up the layout for the collection view based on the container size.
    ///
    /// - Parameter containerSize: The size of the container where the collection view will be displayed.
    func setupLayout(with containerSize: CGSize) {
        // Create a layout to be used
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let minItemWidth: CGFloat = 150
        
        // Calculate the number of cells that can fit in the container width
        let numberOfCells = containerSize.width / minItemWidth
        
        // Calculate the height of each cell based on the image and label heights
        let height: CGFloat = Constants.CurrencyCollectionViewCell.Sizes.imageHeight + Constants.CurrencyCollectionViewCell.Sizes.labelHeight + 30
        
        // Calculate the width of each cell based on the available space
        let width = floor((numberOfCells / floor(numberOfCells)) * minItemWidth)
        
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 1
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = .zero
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // Set the view to be this UICollectionView
        self.collectionView.register(CurrencyCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Identifier.subclassedCell)
        
        // Add constraints for the collection view
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: floatingTitleLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    // MARK: - Floating Title Label
    
    func setupFloatingTitleLabel() {
        view.addSubview(floatingTitleLabel)
        NSLayoutConstraint.activate([
            floatingTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            floatingTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            floatingTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            floatingTitleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

// MARK: - UICollectionViewDataSource

extension CurrencyViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feed.items.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifier.subclassedCell, for: indexPath) as? CurrencyCollectionViewCell {
            let itemPosition = indexPath.row + 1
            let cleanFont = UIFont.systemFont(ofSize: 12, weight: .regular)
            let attributedString = NSAttributedString.cleanAttributedString(text: feed.items[itemPosition].title, font: cleanFont, textColor: .white)
            let imageURl = URL(string: feed.items[itemPosition].featured_image)!
            cell.configure(with: imageURl, text: attributedString, color: UIColor.customGray )
            return cell
        }
        fatalError("Unable to dequeue subclassed cell")
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CurrencyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 180 + 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.Identifier.headerView, for: indexPath) as? HeaderView else {
            fatalError("Failed to dequeue header view.")
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerViewTapped))
        headerView.addGestureRecognizer(tapGesture)
        
        // Fetch image from URL asynchronously
        let imageURL = URL(string: feed.items.first!.featured_image) // Replace with your actual image URL
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL!), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    // Configure the header view with the fetched image
                    headerView.configure(with: image)
                }
            }
        }
        
        let cleanFont = UIFont.systemFont(ofSize: 12, weight: .regular)
        if let attributedString = NSAttributedString.cleanAttributedString(html: feed.items.first!.summary, font: cleanFont, textColor: .white) {
            // Configure the header view with the label text
            headerView.configureLabel(with: attributedString)
        }
        
        return headerView
    }
    
    @objc func headerViewTapped() {
        print("Header view tapped!")
        presentAlertForFeedOn(itemNumber: 0)
    }
}

// MARK: - UICollectionViewDelegate

extension CurrencyViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath.row)")
        presentAlertForFeedOn(itemNumber: indexPath.row + 1)
    }
    
    func presentAlertForFeedOn(itemNumber: Int) {
        let webAlertVC = TransparentWebAlertViewController()
        webAlertVC.htmlString = feed.items[itemNumber].content_html
        present(webAlertVC, animated: true, completion: nil)
    }
}

// MARK: - CurrencyViewControllerDelegate

extension CurrencyViewController: CurrencyViewControllerDelegate {
    func update(with feed: Feed) {
        self.feed = feed
    }
}
