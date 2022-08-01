//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Olzhas Suleimenov on 14.07.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var pictureName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // every ViewController has property storyboard either storyboard it was loaded from or nil you aren't using storyboards
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        
        title = pictureName
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnTap = true
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.hidesBarsOnTap = false
    }

    @objc private func shareTapped() { // make it visible i.e. usable to Objective-C
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        guard let name = pictureName else { return }
        
        let vc = UIActivityViewController(activityItems: [image, name], applicationActivities: [])
        
        // this code for iPad otherwise it will crash on iPads, because on iPad UIActivityController must be shown from somewhere on the screen
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        // present our ViewController on the screen modally (Modal seague)
        present(vc, animated: true)
    }
}
