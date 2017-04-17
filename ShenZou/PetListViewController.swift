//
//  PetListViewController.swift
//  Project: EscanTest
//
//  Module: PetList
//
//  By zcon 2017/4/6
//  zcon 2017年
//

// MARK: Imports

import UIKit

import ListKit
import SwiftyVIPER
import Kingfisher

struct PetItemInfo {
    let imgURL:String
    let name:String
}

class PetItemCell: UITableViewCell, ListKitCellProtocol {
    let imv:UIImageView
    let itemName:UILabel

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        itemName = UILabel()
        imv = UIImageView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        self.separatorInset = .zero
        self.layoutMargins = .zero
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var model: PetItemInfo? {
        didSet {
            if let url = model?.imgURL {
                imv.kf.setImage(with: URL(string:url))
            } else {
                // TODO
//                imv.kf.setImage(with: <#T##Resource?#>)
            }
            self.contentView.addSubview(imv)

            itemName.text = model?.name
            self.contentView.addSubview(itemName)
            self.itemName.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().offset(5)
                make.width.equalTo(100)
                make.height.equalTo(50)
            }

        }
    } // fin model
}

// MARK: Protocols

/// Should be conformed to by the `PetListInteractor` and referenced by `PetListPresenter`
protocol PetListPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The View Controller for the PetList module
class PetListViewController: UIViewController {

	// MARK: - Constants

	let presenter: PetListViewPresenterProtocol

	// MARK: Variables

	// MARK: Inits

	init(presenter: PetListViewPresenterProtocol) {
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
    }
}

// MARK: - PetList Presenter to View Protocol

extension PetListViewController: PetListPresenterViewProtocol {

	func set(title: String?) {
		self.title = title
	}
}
