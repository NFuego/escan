
// MARK: Imports

import UIKit
import ListKit
import SnapKit
import RxCocoa
import RxSwift
import SwiftyJSON
import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `ManualAccountingInteractor` and referenced by `ManualAccountingPresenter`
protocol ManualAccountingPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The View Controller for the ManualAccounting module
class ManualAccountingViewController: UIViewController {

	// MARK: - Constants

	let presenter: ManualAccountingViewPresenterProtocol

	// MARK: Variables
    let dpg = DisposeBag()
    
    var list:UITableView!
    var dataSource : ArrayDataSource<AccountItemCell,AccountItemInfo>?
    var addBtn:UIButton!
    var itemTf:UITextField!
    var costTf:UITextField!

	// MARK: Inits

	init(presenter: ManualAccountingViewPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Load Functions

	override func viewDidLoad() {
    	super.viewDidLoad()
		presenter.viewLoaded()
        
		view.backgroundColor = .white

        // item txt , cost
        itemTf = UITextField()
        itemTf.borderStyle = .roundedRect
        itemTf.textAlignment = .center
        self.view.addSubview(itemTf)
    
        
        costTf = UITextField()
        costTf.borderStyle = .roundedRect
        costTf.textAlignment = .center
        self.view.addSubview(costTf)
        
        itemTf.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(44)
            make.trailing.equalTo(self.view.snp.centerX)
            make.top.equalToSuperview().offset(90)
        }
        costTf.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(44)
            make.leading.equalTo(self.view.snp.centerX)
            make.top.equalToSuperview().offset(90)
        }

        // for demo
        itemTf.text = "service b"
        costTf.text = "250元"
        
        addBtn = UIButton()
        addBtn.setTitleColor(.black, for: .normal)
        addBtn.setTitle("確定", for: .normal)
        addBtn.rx.tap.subscribe ({(evt) in
            /*
            self.dismiss(animated: true , completion: { 
               print("confi")
            })
 */
            let _ = self.navigationController?.popViewController(animated: true)
        }).addDisposableTo(dpg)
        
        self.view.addSubview(addBtn)
        addBtn.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(44)
            make.bottom.equalToSuperview()
        }
        
        // list
        let title = NSLocalizedString("手動輸入", comment: "")
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
           make.top.equalTo(costTf.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(kCodeFrameWidth)
//            make.height.equalTo(120)
            make.bottom.equalTo(self.addBtn.snp.top)
        }
    }
}

// MARK: - ManualAccounting Presenter to View Protocol

extension ManualAccountingViewController: ManualAccountingPresenterViewProtocol {

	func set(title: String?) {
		self.title = title
	}
}

extension ManualAccountingViewController : UITableViewDelegate {
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
