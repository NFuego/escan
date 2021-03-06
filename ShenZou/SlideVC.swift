import Foundation
import EPContactsPicker

func i18n(_ str:String)->String {
    return NSLocalizedString(str, comment: "")
}

class SlideVC : OptsVC, OptsDecoration {

    static let qrcodeScanVC = UINavigationController(rootViewController: StoreAccountingModule().view)

    // For any single origami in the SlideVC should conform to VCDecoration protocol and setNavHeader
    static let swallow = UINavigationController(rootViewController: BirdBase())
    
    var fundamentalOpts:UINavigationController!
    var contactsNav:UINavigationController!
    var cp:EPContactsPicker!

    override func buildOpts(){
        let memoVC = MemoModule().view
        
        let contactView = ContactViewModule().view

        fundamentalOpts = UINavigationController(rootViewController: memoVC)
//        fundamentalOpts = UINavigationController(rootViewController: contactView)

        cp = EPContactsPicker(delegate: self, multiSelection:false, subtitleCellType: SubtitleCellValue.phoneNumber)
        print(cp.contactDelegate)
        contactsNav = UINavigationController(rootViewController: cp)
    

        var header = MenuOpt(title:i18n("menu.about"),targetVC:SlideVC.qrcodeScanVC,icon:"")
        header.header = true
            menuOpts = [
                        header,
                        MenuOpt(title:i18n("menu.memo"),targetVC:self.fundamentalOpts,icon:""),
                        MenuOpt(title:i18n("menu.contacs"),targetVC:self.contactsNav,icon:"")
        ]
    }

    override func viewDidAppear(_ animated: Bool) {
        print(cp.contactDelegate)
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
//*
extension SlideVC : EPPickerDelegate {
    func epContactPicker(_: EPContactsPicker, didContactFetchFailed error : NSError) {

    }
    
    func epContactPicker(_: EPContactsPicker, didCancel error : NSError){

    }
    
    func epContactPicker(_: EPContactsPicker, didSelectContact contact : EPContact){
        print(contact.displayName())
        print(contact)
    }

    func epContactPicker(_: EPContactsPicker, didSelectMultipleContacts contacts : [EPContact]){

    }
}

// */
