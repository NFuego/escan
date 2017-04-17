
import AVFoundation
import UIKit
import QRCodeReader
import SnapKit
import RxSwift
import RxCocoa
import ListKit

    // attr
let kCodeFrameWidth = 200

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
    
    var infos = [AccountItemInfo(itemName: "service a", itemCost: 150)]
    var list:UITableView!
    var dataSource : ArrayDataSource<AccountItemCell,AccountItemInfo>?

    let manualAccountingVC = ManualAccountingModule().view

    override func viewDidLoad() {
       self.view.backgroundColor = .white

        // qrcode
        self.addChildViewController(readerVC)
        self.view.addSubview(readerVC.view)
        readerVC.view.snp.makeConstraints { (make) in
            make.size.equalTo(kCodeFrameWidth)
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }

        // list
        let title = NSLocalizedString("記帳", comment: "")
        self.title = title

        list = UITableView()
        list.backgroundColor = .white
        list.delegate = self


        dataSource = ArrayDataSource(array:infos,cellType:AccountItemCell.self)
        self.list.dataSource = dataSource
        self.view.addSubview(list)
        list.snp.makeConstraints { (make) in
           make.top.equalTo(readerVC.view.snp.bottom).offset(5)
            make.centerX.equalTo(readerVC.view)
            make.width.equalTo(kCodeFrameWidth)
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

        manualAddBtn.rx.tap.subscribe({(evt) in
            self.navigationController?.pushViewController(self.manualAccountingVC, animated: true)
        }).addDisposableTo(dbg)

        lbTotal.text = "總計:450"
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
//        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
//            print("result:\(result)")
//        }
        // Presents the readerVC as modal form sheet
//        readerVC.modalPresentationStyle = .formSheet
//        present(readerVC, animated: true, completion: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        self.reader(readerVC, didScanResult: QRCodeReaderResult(value:"123",metadataType:"321"))
    }
} // qr code scan


// MARK: - QRCodeReaderViewController Delegate Methods
extension QRCodeScanVC : QRCodeReaderViewControllerDelegate {
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
//        reader.stopScanning()
        print("didScanResult\(result)")

        let a = AccountItemInfo(itemName: "service e", itemCost: 150)
        self.infos.append(a)
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.dataSource = ArrayDataSource(array:self.infos,cellType:AccountItemCell.self)
                self.list.dataSource = self.dataSource
                self.list.reloadData()
                self.list.setNeedsLayout()
            }
        }

//        DispatchQueue.global(qos: .userInitiated).async { 
//            DispatchQueue.main.sync {
//            }
//        }


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

/*


这是我在网上找到的相关帖子，还算比较全面了，但是还是有点不明白
layoutSubviews总结

ios layout机制相关方法

    - (CGSize)sizeThatFits:(CGSize)size
- (void)sizeToFit
——————-

- (void)layoutSubviews
- (void)layoutIfNeeded
- (void)setNeedsLayout
——————–

- (void)setNeedsDisplay
- (void)drawRect
layoutSubviews在以下情况下会被调用：

1、init初始化不会触发layoutSubviews

但是是用initWithFrame 进行初始化时，当rect的值不为CGRectZero时,也会触发

2、addSubview会触发layoutSubviews

3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化

4、滚动一个UIScrollView会触发layoutSubviews

5、旋转Screen会触发父UIView上的layoutSubviews事件

6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件

在苹果的官方文档中强调:

You should override this method only if the autoresizing behaviors of the subviews do not offer the behavior you want.

layoutSubviews, 当我们在某个类的内部调整子视图位置时，需要调用。

反过来的意思就是说：如果你想要在外部设置subviews的位置，就不要重写。

刷新子对象布局

-layoutSubviews方法：这个方法，默认没有做任何事情，需要子类进行重写
-setNeedsLayout方法： 标记为需要重新布局，异步调用layoutIfNeeded刷新布局，不立即刷新，但layoutSubviews一定会被调用
-layoutIfNeeded方法：如果，有需要刷新的标记，立即调用layoutSubviews进行布局（如果没有标记，不会调用layoutSubviews）

如果要立即刷新，要先调用[view setNeedsLayout]，把标记设为需要布局，然后马上调用[view layoutIfNeeded]，实现布局

在视图第一次显示之前，标记总是“需要刷新”的，可以直接调用[view layoutIfNeeded]

重绘

-drawRect:(CGRect)rect方法：重写此方法，执行重绘任务
-setNeedsDisplay方法：标记为需要重绘，异步调用drawRect
-setNeedsDisplayInRect:(CGRect)invalidRect方法：标记为需要局部重绘

sizeToFit会自动调用sizeThatFits方法；

sizeToFit不应该在子类中被重写，应该重写sizeThatFits

sizeThatFits传入的参数是receiver当前的size，返回一个适合的size

sizeToFit可以被手动直接调用

sizeToFit和sizeThatFits方法都没有递归，对subviews也不负责，只负责自己

———————————-

layoutSubviews对subviews重新布局

layoutSubviews方法调用先于drawRect

setNeedsLayout在receiver标上一个需要被重新布局的标记，在系统runloop的下一个周期自动调用layoutSubviews

layoutIfNeeded方法如其名，UIKit会判断该receiver是否需要layout.根据Apple官方文档,layoutIfNeeded方法应该是这样的

layoutIfNeeded遍历的不是superview链，应该是subviews链

drawRect是对receiver的重绘，能获得context

setNeedDisplay在receiver标上一个需要被重新绘图的标记，在下一个draw周期自动重绘，iphone device的刷新频率是60hz，也就是1/60秒后重绘
*/
