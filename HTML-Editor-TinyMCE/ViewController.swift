//
//  ViewController.swift
//  HTML-Editor-TinyMCE
//
//  Created by Roman Melnik on 22.02.2023.
//

import WebKit
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let filePath = Bundle.main.url(forResource: "assets/tinyeditor", withExtension: "html") {
            let request = URLRequest(url: filePath)
            webView.load(request)
        }
    }


}

