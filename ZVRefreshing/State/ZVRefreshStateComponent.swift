//
//  ZVRefreshStateComponent.swift
//  ZVRefreshing
//
//  Created by 张伟 on 2018/8/13.
//  Copyright © 2018年 zevwings. All rights reserved.
//

import Foundation

public protocol ZVRefreshStateComponent: AnyObject {
    var stateLabel: UILabel? { get }
    var stateTitles: [ZVRefreshComponent.State : String]? { get set }
}

extension ZVRefreshStateComponent where Self: ZVRefreshComponent {
    
    public func setCurrentStateTitle() {
        guard let stateLabel = stateLabel else { return }
        if stateLabel.isHidden && refreshState == .refreshing {
            stateLabel.text = nil
        } else {
            stateLabel.text = stateTitles?[refreshState]
        }
    }
    
    public func setTitle(_ title: String, for state: ZVRefreshComponent.State) {
        if stateTitles == nil { stateTitles = [:] }
        stateTitles?[state] = title
        stateLabel?.text = stateTitles?[refreshState]
    }
}
