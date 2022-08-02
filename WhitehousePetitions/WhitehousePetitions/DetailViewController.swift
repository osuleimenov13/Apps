//
//  DetailViewController.swift
//  WhitehousePetitions
//
//  Created by Olzhas Suleimenov on 29.07.2022.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?
    
    //The loadView() method is often not needed, because most view layouts are loaded from a storyboard. However, it’s common to write part or all of your user interface in code, and for those times you’re likely to want to replace loadView() with your own implementation.
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let detailItem = detailItem else { return }

        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """

        webView.loadHTMLString(html, baseURL: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
