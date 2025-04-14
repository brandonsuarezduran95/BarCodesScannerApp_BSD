//
//  MainController.swift
//  BarCodesScannerApp_BSD
//
//  Created by Brandon Suarez on 4/13/25.
//

import UIKit
import BarCodeScanner_BSD_SDK

class MainController: UIViewController {
    
    let messageLabel = UILabel()
    let startButton = UIButton(type: .system)
    
    var currentSymbology: Symbology = .qr

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    func setupController() {
        view.backgroundColor = .systemGray6
        title = Constants.title
        navigationController?.navigationBar.prefersLargeTitles = true
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(messageLabel)
        view.addSubview(startButton)
        setupLabel()
        setupStartButton()
        setupRightBarButton()
    }
    
    func setupLabel() {
        messageLabel.text = Constants.mainMessage
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.font = .preferredFont(forTextStyle: .body)
        messageLabel.textColor = .black
        messageLabel.numberOfLines = Constants.messageLabelLines
        messageLabel.textAlignment = .left
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.size12),
            messageLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constants.size20),
            messageLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -Constants.size20),
            messageLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight)
        ])
    }
    
    func setupStartButton() {
        startButton.setTitle(Constants.buttonTitle, for: .normal)
        startButton.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        let showScannerAction = UIAction { [unowned self] _ in
            let controller = ScannerController(symbology: self.currentSymbology)
            navigationController?.pushViewController(controller, animated: true)
        }
        
        startButton.addAction(showScannerAction, for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            startButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
    
    func setupRightBarButton() {
        
        let options: [UIMenuElement] = Symbology.allCases.map { symbology in
            let title = symbology.rawValue
            let state: UIMenuElement.State = (symbology == currentSymbology) ? .on : .off
            let action = UIAction(title: title, state: state) { [weak self] _ in
                self?.currentSymbology = symbology
                self?.setupRightBarButton()
            }
            
            return action
        }
        
        let menu = UIMenu(title: Constants.menuTitle, image: nil, identifier: nil, options: .displayInline, children: options)
        let button = UIBarButtonItem(systemItem: .add, menu: menu)
        navigationItem.rightBarButtonItem = button
    }
}

extension MainController {
    enum Constants {
        static let title = "Scanner App"
        static let mainMessage = "Tap on the '+' button to select the barcode symbology that the scanner will detect."
        static let menuTitle = "Barcode Symbologies"
        static let buttonTitle = "Start Scanning"
        
        static let messageLabelLines: Int = 2
        static let labelHeight: CGFloat = 60
        
        static let buttonWidth: CGFloat = 150
        static let buttonHeight: CGFloat = 30
        
        static let size12: CGFloat = 12
        static let size20: CGFloat = 20
    }
}
