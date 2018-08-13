//
//  Extensions.swift
//  Refresh
//
//  Created by zevwings on 16/3/30.
//  Copyright © 2016年 zevwings. All rights reserved.
//

import UIKit

public extension UIScrollView {
    
    private struct Storage {
        static var refreshHeader: ZVRefreshHeader?
        static var refreshFooter: ZVRefreshFooter?
        static var reloadHandler: ZVReloadDataHandler?
    }

    public var refreshHeader: ZVRefreshHeader? {
        get {
            return Storage.refreshHeader
        }
        set {
            guard refreshHeader != newValue else { return }
            
            refreshHeader?.removeFromSuperview()
            willChangeValue(forKey: "refreshHeader")
            Storage.refreshHeader = newValue
            didChangeValue(forKey: "refreshHeader")
            
            guard let refreshHeader = refreshHeader else { return }
            insertSubview(refreshHeader, at: 0)
        }
    }

    public var refreshFooter: ZVRefreshFooter? {
        get {
            return Storage.refreshFooter
        }
        set {
            guard refreshFooter != newValue else { return }
            
            refreshFooter?.removeFromSuperview()
            willChangeValue(forKey: "refreshFooter")
            Storage.refreshFooter = newValue
            didChangeValue(forKey: "refreshFooter")

            guard let refreshFooter = refreshFooter else { return }
            insertSubview(refreshFooter, at: 0)
        }
    }
    
    public var totalDataCount: Int {
        
        var totalCount: Int = 0
        if isKind(of: UITableView.classForCoder()) {
            
            let tableView = self as? UITableView
            for section in 0 ..< tableView!.numberOfSections {
                totalCount += tableView!.numberOfRows(inSection: section)
            }
        } else if isKind(of: UICollectionView.classForCoder()) {
            
            let collectionView = self as! UICollectionView
            for section in 0 ..< collectionView.numberOfSections  {
                totalCount += collectionView.numberOfItems(inSection: section)
            }
        }
        return totalCount
    }
    
    internal var reloadDataHandler: ZVReloadDataHandler? {
        get {
            return Storage.reloadHandler
        }
        set {
            Storage.reloadHandler = newValue
        }
    }
    
    internal func executeReloadDataBlock() {
        reloadDataHandler?(totalDataCount)
    }
}


extension UIApplication {
    
    override open var next: UIResponder? {
        
        UITableView.once
        UICollectionView.once
        
        return super.next
    }
}

extension UITableView {
    
    fileprivate static let once: Void = {
        UITableView.exchangeInstanceMethod(m1: #selector(UITableView.reloadData),
                                           m2: #selector(UITableView.internal_reloadData))
    }()
    
    @objc private func internal_reloadData() {
        internal_reloadData()
        executeReloadDataBlock()
    }
}

extension UICollectionView {
    
    fileprivate static let once: Void = {
        UICollectionView.exchangeInstanceMethod(m1: #selector(UICollectionView.reloadData),
                                                m2: #selector(UICollectionView.internal_reloadData))
    }()
    
    @objc private func internal_reloadData() {
        internal_reloadData()
        executeReloadDataBlock()
    }
}
