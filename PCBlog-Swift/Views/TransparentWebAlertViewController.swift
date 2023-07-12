import UIKit
import WebKit
/**
 A view controller that presents a transparent web alert with a custom HTML content.
 
 This view controller displays a transparent web alert with a custom HTML content. The alert consists of a title label, a close button, and a web view to display the HTML content. The background color of the alert is set to transparent black with an alpha component of 0.5.
 
 Usage:
 1. Create an instance of `TransparentWebAlertViewController`.
 2. Set the `htmlString` property to the desired HTML content.
 3. Present the view controller using `present(_:animated:completion:)` method.
 
 Example:
 let htmlContent = "<html><body><h1>Hello, World!</h1></body></html>"
 let alertViewController = TransparentWebAlertViewController()
 alertViewController.htmlString = htmlContent
 present(alertViewController, animated: true, completion: nil)

 */
class TransparentWebAlertViewController: UIViewController {

    // MARK: - Properties

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Set the background color to transparent black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "The Currency" // Set the title text
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()

    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("X", for: .normal) // Set the title of the close button
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside) // Add a target to the close button for tap event
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.backgroundColor = .white
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    var htmlString: String? // The HTML content to be displayed in the web view

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews() // Setup the views and their layout constraints
        loadHTMLContent() // Load the HTML content into the web view
    }

    // MARK: - Setup

    // Sets up the views and their layout constraints
    private func setupViews() {
        view.backgroundColor = .clear // Set the view background color to clear
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(closeButton)
        containerView.addSubview(webView)

        let padding: CGFloat = Constants.TransparentWebAlertViewController.Sizes.containerViewPadding
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.TransparentWebAlertViewController.Sizes.titleLabelHeight),

            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            closeButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: Constants.TransparentWebAlertViewController.Sizes.closeButtonSize),
            closeButton.heightAnchor.constraint(equalToConstant: Constants.TransparentWebAlertViewController.Sizes.closeButtonSize),

            webView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }

    // MARK: - HTML Content

    // Loads the HTML content into the web view
    private func loadHTMLContent() {
        if let htmlString = htmlString {
            webView.loadHTMLString(htmlString, baseURL: nil)
        }
    }

    // MARK: - Close Button

    // Handles the tap event on the close button to dismiss the view controller
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
