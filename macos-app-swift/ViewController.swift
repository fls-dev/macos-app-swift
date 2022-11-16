//
//  ViewController.swift
//  test-delete
//
//  Created by Pavel Misko on 16.11.22.
import WebKit
import Cocoa
import WebKit


class ViewController: NSViewController, WKUIDelegate, WKNavigationDelegate {
   
      var webView: WKWebView!
    
    override func loadView() {
          super.loadView()
          
          let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: CGRect(x: 0, y: 0, width: 1440, height: 790), configuration: webConfiguration)
            webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
            webView.navigationDelegate = self
          
            webView.uiDelegate = self
            view = webView
          
          
    }
    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
                
            if navigationAction.targetFrame == nil {
                self.webView.load(navigationAction.request)
            }
            return nil
    }

    
    
    override func viewDidLoad() {
          super.viewDidLoad()

          var myURL: URL!
          myURL = URL(string: "https://crm.mcgroup.pl/")
          let myRequest = URLRequest(url: myURL!)
          webView.load(myRequest)
          webView.allowsBackForwardNavigationGestures = true
          
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            if let title = webView.title {
                print(title)
            }
        }
    }
    
    
    
}

