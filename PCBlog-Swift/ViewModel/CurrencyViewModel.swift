import Foundation

// MARK: - CurrencyViewDelegate

protocol CurrencyViewControllerDelegate {
    func update(with feed: Feed)
}

// MARK: - CurrencyViewModel

struct CurrencyViewModel {

//    private lazy var imageDownloadService = ImageDownloadService()
    var delegate: CurrencyViewControllerDelegate?

    func fetchFeed() {
        // Download and handle the first feed image
        if let feed = Feed.getFeed() {
            updateFeed(with: feed)
           /* if let imageURL = feed.items.first?.featured_image {
                self.imageDownloadService.downloadFromURL(url: imageURL, success: { image in
                    print("Got the image size: \(image.size)")
                    print("The world is good!")
                }, failure: { errorText in
                    print(errorText)
                })
            } else {
                print("Err: Can not get the URL string")
            }*/
        } else {
            print("Err: Can not get the feed")
        }
        
        
    }
    
    func updateFeed(with feed: Feed) {
        delegate?.update(with: feed)
    }
}
