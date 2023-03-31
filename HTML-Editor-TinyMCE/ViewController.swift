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
    
    public func runJS(_ js: String, handler: ((String) -> Void)? = nil) {
        webView.evaluateJavaScript(js) {(result, error) in
            if let error = error {
                print("WKWebViewJavascriptBridge Error: \(String(describing: error)) - JS: \(js)")
                handler?("")
                return
            }
            
            guard let handler = handler else { return }
            if let resultStr = result as? String {
                handler(resultStr)
                return
            }
            handler("") // no result
        }
    }

    @IBAction func getHtmlTap(_ sender: Any) {
        runJS("tinymce.activeEditor.getContent();", handler: {[weak self] html in
            self?.showAlertView(html)
        })
    }
    
}

extension UIViewController {
    func showAlertView(_ title: String?, _ description: String? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Oк", style: .default, handler: {[weak self] _ in
                if title == "Page not found" {
                    self?.navigationController?.popViewController(animated: true)
                }
            }))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
