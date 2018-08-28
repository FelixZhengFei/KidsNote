//
//  SMWebVC.swift
//  SinaMall
//
//  Created by 郑强飞 on 2017/9/11.
//  Copyright © 2017年 郑强飞. All rights reserved.
//

import UIKit
import WebKit

let k_title:String = "title"
let k_ProssView:String = "estimatedProgress"

class SMWebVC : KNBaseVC,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler {
    
    fileprivate var smWebView:WKWebView?
    fileprivate var lineProgressView:UIProgressView?
    public var urlString:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start_Y = 0
        self.view.backgroundColor=UIColor.white
        configWebView()
        creatProgressView()
        addKVO()
        openStringURL()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeKVO()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //打开链接
    fileprivate func openStringURL() {
        guard let path = URL(string:urlString ?? "") else {
            SMWrongAlert.show("打开的网址错误")
            return
        }
        smWebView?.load(URLRequest(url: path))
    }
    
    /**打开新网址*/
    public final func load(_ urlStr:String) {
        guard urlStr.isEmpty
            else {
                smWebView?.load(URLRequest.init(url: (URL.init(string: urlStr))!))
                return
        }
    }
    
    /**返回*/
    
//    override func backButtonClicked() {
//        if (self.smWebView?.canGoBack)! {
//            self.smWebView?.goBack()
//        } else {
//            _ = self.navigationController?.popViewController(animated: true)
//        }
//    }
}

// MARK: - 私有方法
extension SMWebVC {
    
    fileprivate func configWebView() {
        let config = WKWebViewConfiguration()
        config.preferences = WKPreferences()
        config.preferences.minimumFontSize = 10
        config.preferences.javaScriptEnabled = true
        config.preferences.javaScriptCanOpenWindowsAutomatically = false
        
        smWebView = WKWebView(frame:CGRect(x: 0, y:start_Y, width: MSC_WIDTH, height: MSC_HEIGHT - start_Y), configuration: config)
        smWebView?.customUserAgent=SMUser_Agent
        smWebView?.navigationDelegate = self
        smWebView?.uiDelegate=self
        self.view.addSubview(smWebView!)
        smWebView?.allowsBackForwardNavigationGestures = true
        self.hideNavigationBar()
    }
    
    /**显示自身的导航栏*/
    public func showNavigationBar() {
        self.view.sendSubview(toBack: smWebView!)
    }
    
    /**隐藏自身的导航栏*/
    public func hideNavigationBar() {
        self.view.bringSubview(toFront: smWebView!)
    }
    
    fileprivate func creatProgressView() {
        lineProgressView = UIProgressView(frame: CGRect(x: 0, y: start_Y, width: MSC_WIDTH, height: MSC_HEIGHT - start_Y))
        lineProgressView?.progressTintColor = SMTHEME_COLOR
        lineProgressView?.trackTintColor = UIColor.white
        self.view.addSubview(lineProgressView!)
    }
    
    fileprivate func addKVO() {
        smWebView?.addObserver(self, forKeyPath: k_title, options: .new, context: nil)
        smWebView?.addObserver(self, forKeyPath: k_ProssView, options: .new, context: nil)
    }
    
    fileprivate func removeKVO() {
        if smWebView != nil {
            smWebView?.removeObserver(self, forKeyPath: k_title)
            smWebView?.removeObserver(self, forKeyPath: k_ProssView)
        }
    }
}

// MARK: - WKWebViewDelegate
extension SMWebVC {
    
    //在发送请求之前，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        self.lineProgressView?.alpha = 1
        decisionHandler(.allow)
    }
    
    //在响应完成时，调用的方法。如果设置为不允许响应，web内容就不会传过来
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    // 接收到服务器跳转请求之后调用
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
    }
    
    //开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }
    
    //当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    }
    
    //页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.lineProgressView?.alpha = 0
    }
    
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    }
    
    //页面需要打开新窗口的时候调用
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        let web = SMWebVC()
        web.urlString=navigationAction.request.url?.absoluteString
        web.showNavigationBar()
        if let nav=UIApplication.shared.keyWindow?.rootViewController {
            if nav.isKind(of: UINavigationController.classForCoder()) {
                (nav as! UINavigationController).pushViewController(web, animated: true)
            }
        }
        return nil
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    }
    
    /**KVO监听函数*/
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == k_title {
            self.title = smWebView?.title
            
        } else if keyPath == k_ProssView {
            lineProgressView?.progress = Float((smWebView?.estimatedProgress)!)
        }
        if !((smWebView?.isLoading)!) {
            UIView.animate(withDuration: 0.5, animations: {
                self.lineProgressView?.alpha = 0
            })
        }
    }
}



