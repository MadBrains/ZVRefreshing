//
//  ZRefreshBackStateNormalFooter.swift
//
//  Created by ZhangZZZZ on 16/4/1.
//  Copyright © 2016年 ZhangZZZZ. All rights reserved.
//

import UIKit

public class ZVRefreshBackNormalFooter: ZVRefreshBackStateFooter {
    
    public private(set) lazy var activityIndicator : ZVActivityIndicatorView = {
        var activityIndicator = ZVActivityIndicatorView()
        activityIndicator.color = .lightGray
        return activityIndicator
    }()
    
    open override var tintColor: UIColor! {
        get {
            return super.tintColor
        }
        set {
            super.tintColor = newValue
            activityIndicator.color = newValue
        }
    }
    
    public override var refreshState: State {
        get {
            return super.refreshState
        }
        set {
            let checked = checkState(newValue)
            guard checked.result == false else { return }
            super.refreshState = newValue
            
            switch newValue {
            case .idle:
                if checked.oldState == .refreshing {
                    UIView.animate(withDuration: Config.AnimationDuration.fast, animations: {
                        self.activityIndicator.alpha = 0.0
                    }, completion: { finished in
                        self.activityIndicator.alpha = 1.0
                        self.activityIndicator.stopAnimating()
                    })
                } else {
                    activityIndicator.stopAnimating()
                }
                break
            case .pulling:
                activityIndicator.stopAnimating()
                break
            case .refreshing:
                activityIndicator.startAnimating()
                break
            case .noMoreData:
                activityIndicator.stopAnimating()
                break
            default:
                break
            }
        }
    }
    
    public override var pullingPercent: CGFloat {
        get {
            return super.pullingPercent
        }
        set {
            super.pullingPercent = newValue
            activityIndicator.percent = newValue
        }
    }
    
    public override func prepare() {
        super.prepare()
        
        if activityIndicator.superview == nil {
            addSubview(activityIndicator)
        }
    }
    
    public override func placeSubViews() {
        super.placeSubViews()
        
        var centerX = width * 0.5
        if !stateLabel.isHidden {
            centerX -= (stateLabel.getTextWidth() * 0.5 + labelInsetLeft)
        }
        
        let centerY = height * 0.5
        
        if activityIndicator.constraints.count == 0 {
            
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 24.0, height: 24.0)
            activityIndicator.center = CGPoint(x: centerX, y: centerY)
        }
    }

}

extension ZVRefreshBackNormalFooter {
    
}
