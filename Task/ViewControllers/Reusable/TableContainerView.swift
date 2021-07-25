//
//  MyProductsCatalogueViewController.swift
//  Telenet
//
//  Created by Deepak Shukla on 01/06/2020.
//  Copyright © 2020 Telenet. All rights reserved.
//

import UIKit

// TODO: Collection view height being calculating in story board based on cell aspect ratio. Bring it to code so that it is more readable

// MARK: Protocol

protocol TableViewDelegate: AnyObject {
    func carouselContainerView(_ view: TableContainerView, didSelectItemAt selectedIndex: Int)
    
    func carouselContainerView(_ view: TableContainerView, willMoveItemAt movedIndex: Int)
}

protocol TableViewDataSource: AnyObject {
    var cellType: AnyClass { get }
    var size: CGSize? { get }
    var contentInset: UIEdgeInsets { get }

    func render(_ cell: UITableViewCell, at index: Int)
    func numberOfItems(for section: Int) -> Int
}


// MARK: Class

class TableContainerView: UIView, NibLoadable {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionViewHeighConstraint: NSLayoutConstraint!
    private var currentOffset: CGFloat = 0.0

    weak var delegate: TableViewDelegate?

    weak var dataSource: TableViewDataSource? {
        didSet {
            configCollectionView()
        }
    }

    private var numberOfItems: Int {
        let section = 0
        return dataSource?.numberOfItems(for: section) ?? 0
    }

    private var collectionViewHeight: CGFloat {
        let verticalInset = collectionViewInsets.bottom + collectionViewInsets.top
        guard let height = dataSource?.size?.height else { return verticalInset + 8 }
        return height + verticalInset
    }

    private var collectionViewInsets: UIEdgeInsets {
        return dataSource?.contentInset ?? UIEdgeInsets()
    }

    private var reuseIdentifier: String {
        guard let dataSource = dataSource else { return "" }
        return String(describing: dataSource.cellType)
    }


    // MARK: LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        configViews()
    }
    
    func configViews() {
        backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        tableView.register(AppointmentListTableViewCell.self, forCellReuseIdentifier: "AppointmentListTableViewCell")

    }

    private func configCollectionView() {
        // Register Cell
        guard let dataSource = dataSource else { return }
//        let bundle = Bundle(for: dataSource.cellType)
   //     let nib = UINib(nibName: "TableContainerView", bundle: .main)
       // let view = AppointmentListTableViewCell.fromNib()
    //    tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
      //  tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }

    // MARK: Render

    func render(_ animated: Bool) {
        tableView.reloadData()
        refreshViews()
    }
    
    private func refreshViews() {
        
    }
}

// MARK: - UITableViewDataSource

extension TableContainerView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? AppointmentListTableViewCell else {
            return UITableViewCell()
        }
        dataSource?.render(cell, at: indexPath.row)
        return cell
    }
}


// MARK: - UITableViewDelegate

extension TableContainerView: UITableViewDelegate {

    
}
