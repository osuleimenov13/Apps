//
//  MainViewController.swift
//  EasyBrowser
//
//  Created by Olzhas Suleimenov on 25.07.2022.
//

import UIKit

class MainViewController: UITableViewController {
    
    // our Model although very simple so far
    var websites = ["apple.com", "hackingwithswift.com"]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Easy Browser"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WebView") as? WebViewViewController {
            vc.websites = websites
            vc.websiteIndex = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
