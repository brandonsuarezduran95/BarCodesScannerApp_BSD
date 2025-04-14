//
//  ScannerController.swift
//  BarCodesScannerApp_BSD
//
//  Created by Brandon Suarez on 4/14/25.
//

import UIKit
import BarCodeScanner_BSD_SDK
import Combine


class ScannerController: UIViewController {
    let scannerController: BarCodeScannerController
    let label = UILabel()
    let containerView = UIView()
    var cancelable: AnyCancellable?
    
    init(symbology: Symbology) {
        self.scannerController = BarCodeScannerController(symbology: symbology)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupSubscriber()
    }
    
    func setupSubscriber() {
        cancelable = scannerController.barCodeResponse.receive(on: DispatchQueue.main).sink { [weak self] scannedCode in
            self?.label.text = scannedCode
        }
    }
    
    func setupController() {
        view.backgroundColor = .systemGray3
        view.addSubview(containerView)
        setupScannerController()
        setupLabelAndContainer()
    }
    
    func setupScannerController() {
        addChild(scannerController)
        scannerController.didMove(toParent: self)
        view.addSubview(scannerController.view)
        
        scannerController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scannerController.view.topAnchor.constraint(equalTo: view.topAnchor),
            scannerController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            scannerController.view.bottomAnchor.constraint(equalTo: containerView.topAnchor),
            scannerController.view.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func setupLabelAndContainer() {
        
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "Scanned Code Values Will be shown here"
        
        containerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 120),
            
            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            label.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 12),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),
            label.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -12)
        ])
    }
}

