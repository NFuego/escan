import Foundation

func i18n(_ str:String)->String {
    return NSLocalizedString(str, comment: "")
}

class SlideVC : OptsVC, OptsDecoration {

    static let qrcodeScanVC = UINavigationController(rootViewController: QRCodeScanVC())

    // For any single origami in the SlideVC should conform to VCDecoration protocol and setNavHeader
    static let swallow = UINavigationController(rootViewController: BirdBase())
    
    
    var fundamentalOpts:UINavigationController!
    
    override func buildOpts(){
        
        let memoVC = MemoModule().view
        fundamentalOpts = UINavigationController(rootViewController: memoVC)
        
        var header = MenuOpt(title:i18n("menu.about"),targetVC:SlideVC.qrcodeScanVC,icon:"")
        header.header = true
            menuOpts = [
                        header,
                        MenuOpt(title:i18n("menu.memo"),targetVC:self.fundamentalOpts,icon:""),
                        MenuOpt(title:i18n("menu.swallow"),targetVC:SlideVC.swallow,icon:"")
        ]
    }

    override func whenHighlight(_ cell: UITableViewCell) {
        let cell = cell as! MenuOptCell
        cell.backgroundColor = self.randomBGColor()
        cell.lbVal.textColor = .white
    }

    override func whenUnhighlight(_ cell: UITableViewCell) {
        let cell = cell as! MenuOptCell
        cell.backgroundColor = UIColor.white
        cell.lbVal.textColor = UIColor.options
    }
    
//    override func showVC(_ vc:UIViewController){
////        self.pushViewController(vc,animated:true):
//        self.navigationController?.pushViewController(vc,animated:true)
//
//    }
} // fin SlideVC

// MARK: - SlideVC helper
extension SlideVC {

}
