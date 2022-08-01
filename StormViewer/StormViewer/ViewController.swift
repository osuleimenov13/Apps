//
//  ViewController.swift
//  StormViewer
//
//  Created by Olzhas Suleimenov on 14.07.2022.
//

import UIKit

class ViewController: UITableViewController { //create screen called ViewController based on Apple own UITableViewController screen(view), it inherits functionality of UITableViewController class inside its ViewController class
    
    private var pictures = [String]()
    private lazy var sortedPictures = pictures.sorted()
    private let appLink = "https://www.stormviewer.com"

    // gets called when screen/view has loaded and ready for you to customize
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let fm = FileManager.default
            let path = Bundle.main.resourcePath! //iOS will always have this so this is safe to force unwrap this
            let items = try! fm.contentsOfDirectory(atPath: path) // try to read the contents of our resoursePath, it can crash but if we can't read the contents of our app bundle something is fundumentally wrong with our app and the app won't even work
            
            for item in items {
                if item.hasPrefix("nssl") {
                    self?.pictures.append(item)
                }
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)  // creates new constant cell by dequeing recycled cell from the table
        cell.textLabel?.text = sortedPictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = sortedPictures[indexPath.row]
            vc.pictureName = "Picture \(indexPath.row + 1) of \(sortedPictures.count)"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc private func shareTapped() {
        let vc = UIActivityViewController(activityItems: [appLink], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

