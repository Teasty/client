import UIKit
import WebKit

class LicenseView: BaseController, WKNavigationDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDismissButton()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        let webView = WKWebView()
        guard let url = Bundle.main.url(forResource: "License", withExtension: "doc") else {
            fatalError("Can't find property list.")
        }
        do {
            webView.loadFileURL(url, allowingReadAccessTo: url)
            webView.navigationDelegate = self
            view = webView
            view.addSubview(buttonClose)
            buttonClose.snp.makeConstraints { (make) in
                make.top.equalTo(20)
                make.right.equalTo(-20)
                make.height.equalTo(34)
                make.width.equalTo(34)
            }
        }
    }
}
