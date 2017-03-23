//
//  MemoViewController.swift
//  Project: EscanTest
//
//  Module: Memo
//
//  By zcon 2017/3/23
//  zcon 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

import SnapKit

import RxSwift
import RxCocoa

struct MemoItem {
    let createdAt:String
    let detail:String
    // todo : local schedule
}

class MemoItemCell : UITableViewCell {
    let itemName:UILabel
    let itemDetail:UILabel

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        itemName = UILabel()
        itemDetail = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        self.separatorInset = .zero
        self.layoutMargins = .zero
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var model: MemoItem? {
        didSet {
            itemName.text = model?.createdAt
            self.contentView.addSubview(itemName)
            self.itemName.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().offset(5)
                make.width.equalTo(100)
                make.height.equalTo(50)
            }

            itemDetail.text = model?.detail
            self.contentView.addSubview(itemDetail)
            self.itemDetail.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(itemName.snp.right).offset(5)
//                make.trailing.equalToSuperview().offset(5)
                make.width.equalTo(150)
                make.height.equalTo(50)
            }
        }
    } // fin model

} // fin MemoItemCell

// MARK: Protocols

/// Should be conformed to by the `MemoInteractor` and referenced by `MemoPresenter`
protocol MemoPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The View Controller for the Memo module
class MemoViewController: UIViewController {

	// MARK: - Constants

	let presenter: MemoViewPresenterProtocol

	// MARK: Variables
    let memoAddForm = MemoAddFormModule().view
    let memoCellId = "memoCellId"
    var list:UITableView!
    var memoItems = [MemoItem(createdAt: "2017/03/20", detail:"Todo todo and todo.."),
                 MemoItem(createdAt: "2017/03/20", detail:"Todo todo and todo.."),
                 MemoItem(createdAt: "2017/03/20", detail:"Todo todo and todo.."),
                 MemoItem(createdAt: "2017/03/20", detail:"Todo todo and todo.."),
                 MemoItem(createdAt: "2017/03/20", detail:"Todo todo and todo.."),
                 MemoItem(createdAt: "2017/03/20", detail:"Todo todo and todo..")]

	// MARK: Inits
	init(presenter: MemoViewPresenterProtocol) {
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

        /*
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.barCr
        self.navigationController?.navigationBar.tintColor = .white
        self.title = "預約"
 */
        let add = UIBarButtonItem(title: "增加", style: .plain, target: self, action: #selector(self.addMemoItem))
        self.navigationItem.rightBarButtonItem = add

		view.backgroundColor = .white
        
        // list
        let title = NSLocalizedString("行事曆", comment: "")
        self.title = title

        list = UITableView()
        list.register(MemoItemCell.self, forCellReuseIdentifier: memoCellId)
        list.backgroundColor = .white
        list.delegate = self

        self.list.dataSource = self
        self.view.addSubview(list)
        list.snp.makeConstraints { (make) in

            /*
           make.top.equalTo(readerVC.view.snp.bottom).offset(5)
            make.width.equalTo(kCodeFrameWidth)
            make.height.equalTo(120)
 */
            make.size.equalToSuperview()
        }
    }
}

// MARK: - helper
extension MemoViewController {
    func addMemoItem(){
       self.navigationController?.pushViewController(memoAddForm, animated: true)
    }
}

// MARK: - Memo Presenter to View Protocol

extension MemoViewController: MemoPresenterViewProtocol {

	func set(title: String?) {
		self.title = title
	}

    
}

extension MemoViewController : UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = list.dequeueReusableCell(withIdentifier: memoCellId) as! MemoItemCell
        cell.model = self.memoItems[indexPath.row]
        return cell
    }

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoItems.count
    }


    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       return true
    }
}

extension MemoViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }


    //If you want to change title
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Cancel"
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // you might want to delete the item at the array first before calling this function
            self.memoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    /*
    func tableView(_ tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }


    func tableView(tableView: (UITableView!), commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: (NSIndexPath!)) {

    }

    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {

        var deleteAction = UITableViewRowAction(style: .Default, title: "Delete") {action in
            //handle delete
        }

        var editAction = UITableViewRowAction(style: .Normal, title: "Edit") {action in
            //handle edit
        }
        
        return [deleteAction, editAction]
    }
 */
    
}
