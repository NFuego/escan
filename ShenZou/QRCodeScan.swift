
import AVFoundation
import UIKit
import QRCodeReader
import SnapKit

import RxSwift
import  RxCocoa
import ListKit

struct AccountItemInfo {
    let itemName:String
    let itemCost:Int
}

/*
 https://uxdesign.cc/the-best-youtube-channels-for-designers-and-developers-eda97b38d46a#.shw9c2bpe
 */

class AccountItemCell: UITableViewCell, ListKitCellProtocol {
    let itemName:UILabel
    let itemCost:UILabel

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        itemName = UILabel()
        itemCost = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        self.separatorInset = .zero
        self.layoutMargins = .zero
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var model: AccountItemInfo? {
        didSet {
            itemName.text = model?.itemName
            self.contentView.addSubview(itemName)
            self.itemName.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().offset(5)
                make.width.equalTo(100)
                make.height.equalTo(50)
            }

            itemCost.text = model?.itemCost.description
            self.contentView.addSubview(itemCost)
            self.itemCost.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().offset(5)
                make.width.equalTo(100)
                make.height.equalTo(50)
            }
            /*
            self.overlay.addSubview(self.textLabel!)
            self.textLabel!.text = model?.name as String?
            self.textLabel!.font = UIFont.systemFont(ofSize: 25)
            self.textLabel!.textColor = .white
            self.textLabel!.textAlignment = .center
            self.textLabel!.snp.makeConstraints { (make) in
                make.width.equalToSuperview()
                make.centerY.equalToSuperview()
            }
 */
        }
    } // fin model
}

class QRCodeScanVC : UIViewController {
    
    lazy var readerVC = QRCodeReaderViewController(builder: QRCodeReaderViewControllerBuilder {
        let readerView = QRCodeReaderContainer(displayable: QRCodeReaderView())

        $0.readerView = readerView
    })

    // Var
    let dbg = DisposeBag()
    let btnScan = UIButton()
    let manualAddBtn = UIButton()
    let resetBtn = UIButton()
    let submitBtn = UIButton()
    let lbTotal = UILabel()

    var list:UITableView!
    var dataSource : ArrayDataSource<AccountItemCell,AccountItemInfo>?

    // attr
    let codeFrameWidth = 200

    override func viewDidLoad() {
       self.view.backgroundColor = .white

        // qrcode
        self.addChildViewController(readerVC)
        self.view.addSubview(readerVC.view)
        readerVC.view.snp.makeConstraints { (make) in
            make.size.equalTo(codeFrameWidth)
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }

        // list
        let title = NSLocalizedString("記帳", comment: "")
        self.title = title

        list = UITableView()
        list.backgroundColor = .white
        list.delegate = self

        let infos = [AccountItemInfo(itemName: "service a", itemCost: 150),
                     AccountItemInfo(itemName: "service b", itemCost: 250),
                     AccountItemInfo(itemName: "service c", itemCost: 300),
                     AccountItemInfo(itemName: "service d", itemCost: 200),
                     AccountItemInfo(itemName: "service e", itemCost: 100),
                     AccountItemInfo(itemName: "service f", itemCost: 1500) ]

        dataSource = ArrayDataSource(array:infos,cellType:AccountItemCell.self)
        self.list.dataSource = dataSource
        self.view.addSubview(list)
        list.snp.makeConstraints { (make) in
           make.top.equalTo(readerVC.view.snp.bottom).offset(5)
            make.centerX.equalTo(readerVC.view)
            make.width.equalTo(codeFrameWidth)
            make.height.equalTo(120)
        }

        // manual add
        manualAddBtn.setTitle("手動輸入", for: .normal)
        manualAddBtn.setTitleColor(.black, for: .normal)
       self.view.addSubview(manualAddBtn)
        manualAddBtn.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.top.equalTo(list.snp.bottom).offset(5)
            make.trailing.equalTo(list.snp.centerX)
        }

        lbTotal.text = "450"
        lbTotal.textAlignment = .center
        self.view.addSubview(lbTotal)
        lbTotal.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.top.equalTo(list.snp.bottom).offset(5)
            make.leading.equalTo(list.snp.centerX)
        }

        resetBtn.setTitle("重設", for: .normal)
        resetBtn.setTitleColor(.black, for: .normal)
       self.view.addSubview(resetBtn)
        resetBtn.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.top.equalTo(manualAddBtn.snp.bottom).offset(5)
            make.trailing.equalTo(list.snp.centerX)
        }

        submitBtn.setTitle("送出", for: .normal)
        submitBtn.setTitleColor(.black, for: .normal)
       self.view.addSubview(submitBtn)
        submitBtn.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.top.equalTo(lbTotal.snp.bottom).offset(5)
            make.leading.equalTo(list.snp.centerX)
        }

        // qr scan button
       btnScan.setTitle("掃描", for: .normal)
       btnScan.setTitleColor(.black, for:.normal)
        self.view.addSubview(btnScan)
        btnScan.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(44)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        btnScan.rx.tap.subscribe({(evt) in
            self.scanAction()
        }).addDisposableTo(dbg)

        
    }

    /*
    lazy var readerVC = QRCodeReaderViewController(builder: QRCodeReaderViewControllerBuilder {
        $0.reader = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode], captureDevicePosition: .back)
    })
 */

    func scanAction() {
        // Retrieve the QRCode content
        // By using the delegate pattern
        readerVC.delegate = self
        readerVC.startScanning()

        // Or by using the closure pattern
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            print("result:\(result)")
        }
        // Presents the readerVC as modal form sheet
//        readerVC.modalPresentationStyle = .formSheet
//        present(readerVC, animated: true, completion: nil)
    }
} // qr code scan


// MARK: - QRCodeReaderViewController Delegate Methods
extension QRCodeScanVC : QRCodeReaderViewControllerDelegate {
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
//        reader.stopScanning()

        print("didScanResult\(result)")
 //       dismiss(animated: true, completion: nil)
    }

    //This is an optional delegate method, that allows you to be notified when the user switches the cameraName
    //By pressing on the switch camera button
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        if let cameraName = newCaptureDevice.device.localizedName {
            print("Switching capturing to: \(cameraName)")
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        print("stopScann")
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
    
}

extension QRCodeScanVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }

    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionReveal
        self.navigationController?.view.layer.add(transition, forKey: nil)

        let u = UIViewController()
        self.navigationController?.pushViewController(u, animated: false)
    }
 */
}
