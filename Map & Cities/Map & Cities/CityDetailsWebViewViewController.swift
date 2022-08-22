//
//  CityDetailsWebViewViewController.swift
//  Map & Cities
//
//  Created by Olzhas Suleimenov on 22.08.2022.
//

import UIKit
import WebKit

class CityDetailsWebViewViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView?
    var city: Cities?
    
    enum Cities {
        case London, Oslo, Paris, Rome, Washington
    }
    
    // loadView gets called before viewDidLoad although we can position it anywhere inside the class
    override func loadView() {
        webView = WKWebView()
        // delegation is programming pattern, a way of writing code and used extensively in iOS
        // WKWebView doesn't know or care how our application want to behave because its our custom code and by delegation we will be informed once something interesting in WKWebView navigation will happen
        webView?.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var url: URL
        
        switch city {
        case .London:
            url = URL(string: "https://en.wikipedia.org/wiki/London")!
        case .Oslo:
            url = URL(string: "https://en.wikipedia.org/wiki/Oslo")!
        case .Paris:
            url = URL(string: "https://en.wikipedia.org/wiki/Paris")!
        case .Rome:
            url = URL(string: "https://en.wikipedia.org/wiki/Rome")!
        case .Washington:
            url = URL(string: "https://en.wikipedia.org/wiki/Washington,_D.C.")!
        case .none:
            url = URL(string: "https://en.wikipedia.org/wiki/London")!
        }
        
        webView?.load(URLRequest(url: url))
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
