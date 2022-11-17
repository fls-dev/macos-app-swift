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
   
    var cook: String = "no";
    
    override func loadView() {
          super.loadView()
          
          let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: CGRect(x: 0, y: 0, width: 1200, height: 800), configuration: webConfiguration)
            webView.navigationDelegate = self
            webView.uiDelegate = self
            view = webView
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
        
        var myURL: URL!
        myURL = URL(string: "https://crm.mcgroup.pl/")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        webView.allowsBackForwardNavigationGestures = true;
        webView.navigationDelegate = self
        
        webView.getCookies(for: ".mcgroup.pl") { data in
            self.cook = String(describing: data["mia_consult_group_session"])
        }
    
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            if let title = webView.title {
                self.view.window?.title = title
                self.view.window?.update()
            }
        }
        if let url = webView.url {
            print(url)
        }
    }
    
   
    
    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                self.webView.load(navigationAction.request)
            }
            return nil
    }
   
}


extension WKWebView {

    private var httpCookieStore: WKHTTPCookieStore  { return WKWebsiteDataStore.default().httpCookieStore }

    func getCookies(for domain: String? = nil, completion: @escaping ([String : String])->())  {
        var cookieDict = [String : String]()
        httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                if let domain = domain {
                    if cookie.domain.contains(domain) {
                        cookieDict[cookie.name] = cookie.value
                    }
                } else {
                    cookieDict[cookie.name] = cookie.value
                }
            }
            completion(cookieDict)
        }
    }
    
    
    
    
}
