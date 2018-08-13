//
//  ZRefreshBackStateFooter.swift
//
//  Created by zevwings on 16/4/1.
//  Copyright © 2016年 zevwings. All rights reserved.
//

import UIKit

open class ZVRefreshBackStateFooter: ZVRefreshBackFooter {
    
    // MARK: - Property
    
    public var labelInsetLeft: CGFloat = 12.0
    public var stateTitles: [State : String]?
    public var stateLabel: UILabel?
    
    // MARK: - Subviews
    
    override open func prepare() {
        super.prepare()
        
        if stateLabel == nil {
            stateLabel = .default
            addSubview(stateLabel!)
        }
                
        setTitle(localized(string: LocalizedKey.BackFooter.idle), for: .idle)
        setTitle(localized(string: LocalizedKey.BackFooter.pulling), for: .pulling)
        setTitle(localized(string: LocalizedKey.BackFooter.refreshing), for: .refreshing)
        setTitle(localized(string: LocalizedKey.BackFooter.noMoreData), for: .noMoreData)
    }
    
    override open func placeSubViews() {
        super.placeSubViews()
        
        if let stateLabel = stateLabel, stateLabel.constraints.count == 0 {
            stateLabel.frame = bounds
        }
    }
    
    // MARK: - Do On State
    
    override open func doOnAnyState(with oldState: State) {
        super.doOnAnyState(with: oldState)
        
        setCurrentStateTitle()
    }
}

// MARK: - Override

extension ZVRefreshBackStateFooter {
    
    override open var tintColor: UIColor! {
        didSet {
            stateLabel?.textColor = tintColor
        }
    }
}

// MARK: - ZVRefreshStateComponent

extension ZVRefreshBackStateFooter: ZVRefreshStateComponent {}

