//
//  ViewController.swift
//  ViewControllerContainment
//
//  Created by Richard Garrison on 4/4/21.
//

import UIKit

class MasterViewController: UIViewController {
    
    @IBOutlet var segmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    private func setupView() {
        setupSegmentedControl()
        
        updateView()
    }
    
    private func setupSegmentedControl() {
        // Configure Segmented Control
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Summary", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Sessions", at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        
        // Select First Segment
        segmentedControl.selectedSegmentIndex = 0
    }
    
    @objc func selectionDidChange(_ sender: UISegmentedControl) {
        updateView()
    }
    
    private lazy var summaryViewController: SummaryViewController = {
        // Load Story Board
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(identifier: "SummaryViewController") as! SummaryViewController
        
        // Add View Controller as Child View Controller
        self.addChild(viewController)
        
        return viewController
        
    }()
    
    private lazy var sessionsViewController: SessionsViewController = {
        // Load Story Board
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(identifier: "SessionsViewController") as! SessionsViewController
        
        // Add View Controller as Child View Controller
        self.addChild(viewController)
        
        return viewController
        
    }()
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Chuild View from Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
        
    }
    
    private func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: sessionsViewController)
            add(asChildViewController: summaryViewController)
        } else {
            remove(asChildViewController: summaryViewController)
            add(asChildViewController: sessionsViewController)
        }
    }


}

