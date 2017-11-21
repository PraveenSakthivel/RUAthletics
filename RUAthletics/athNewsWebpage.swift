//
//  athNewsWebpage.swift
//  RUAthletics
//
//  Created by Praveen Sakthivel on 11/17/17.
//  Copyright © 2017 TBLE Technologies. All rights reserved.
//

import UIKit
import WebKit

class athNewsWebpage: UIViewController,WKUIDelegate, WKNavigationDelegate {
    var link:String = String()
    @IBOutlet var Webview: WKWebView!
    @IBOutlet var LoadingIcon: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Webview.uiDelegate = self
        Webview.navigationDelegate = self
        Webview.load(URLRequest.init(url: URL.init(string: link)!))
        let backText = UIButton(type: .custom)
        backText.frame = CGRect(x: 0, y: 0, width: 40, height: 80)
        backText.setTitle("<", for: UIControlState())
        backText.setTitleColor(UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: UIControlState())
        backText.titleLabel!.font = UIFont(name: "Helvetica", size: 30)
        let forText = UIButton(type: .custom)
        forText.frame = CGRect(x: 0, y: 0, width: 40, height: 80)
        forText.setTitle(">", for: UIControlState())
        forText.setTitleColor(UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: UIControlState())
        forText.titleLabel!.font = UIFont(name: "Helvetica", size: 30)
        let back = UIBarButtonItem(customView: backText)
        let forward = UIBarButtonItem(customView: forText)
        self.navigationItem.rightBarButtonItems = [forward,back]
        backText.addTarget(self, action: #selector(self.goB), for: UIControlEvents.touchUpInside)
        forText.addTarget(self, action: #selector(self.goF), for: UIControlEvents.touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    func goF(){
        Webview.goForward()
    }
    func goB(){
        Webview.goBack()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        LoadingIcon.isHidden = false
        LoadingIcon.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        LoadingIcon.stopAnimating()
        LoadingIcon.isHidden = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
