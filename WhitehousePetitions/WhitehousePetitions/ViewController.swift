//
//  ViewController.swift
//  WhitehousePetitions
//
//  Created by Olzhas Suleimenov on 28.07.2022.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()

    // parse JSON means to process it and examine its content
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Whitehouse Petitions"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showInfo))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
        
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
            
        DispatchQueue.global(qos: .userInitiated).async {
            [weak self] in
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self?.parse(json: data)
                    return
                }
            }
            
            self?.showError()
        }
    }
    
    @IBAction func search(_ sender: Any) {
        let ac = UIAlertController(title: "Search", message: "Type in what you want to search", preferredStyle: .alert)
        ac.addTextField()
        let filterAction = UIAlertAction(title: "Find", style: .default) { [weak self, weak ac] _ in
            guard let text = ac?.textFields?[0].text else { return }
            self?.filterData(by: text)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(filterAction)
        ac.addAction(cancelAction)
        present(ac, animated: true)
    }
    
    @IBAction func refreshSearch(_ sender: Any) {
        viewDidLoad()
    }
    
    private func parse(json: Data) {
        // JSONDecoder is one of Swift's core types which decode json into object of our choosing
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    private func showError() {
        DispatchQueue.main.async { [weak self] in
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(ac, animated: true)
        }
    }
    
    @objc func showInfo() {
        let ac = UIAlertController(title: "Info", message: "Data comes from the We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
                     
    private func filterData(by text: String) {
        //let lowercasedPetitions = petitions.map { $0.lowercasePetition() }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let filteredPetitions = self?.petitions.filter { $0.title.localizedCaseInsensitiveContains(text) || $0.body.localizedCaseInsensitiveContains(text) }
            if let filteredPetitions = filteredPetitions {
                self?.petitions = filteredPetitions
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        
        // asking for new fresh empty configuration
        var content = cell.defaultContentConfiguration()
        content.text = petition.title
        content.secondaryText = petition.body
        //content.image = UIImage(systemName: "star")
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 55
//    }
    
//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 10
//    }
}

