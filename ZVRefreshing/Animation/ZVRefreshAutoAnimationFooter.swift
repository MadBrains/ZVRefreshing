//
//  ZRefreshAutoAnimationFooter.swift
//
//  Created by zevwings on 16/4/1.
//  Copyright © 2016年 zevwings. All rights reserved.
//

import UIKit


open class ZVRefreshAutoAnimationFooter: ZVRefreshAutoStateFooter {
    
    // MARK: - Property
    
    public private(set) var animationView: UIImageView?
    
    public var stateImages: [State: [UIImage]]?
    public var stateDurations: [State: TimeInterval]?
    
    // MARK: - Subviews
    
    override open func prepare() {
        super.prepare()

        if animationView == nil {
            animationView = UIImageView()
            animationView?.backgroundColor = .clear
            addSubview(animationView!)
        }
    }
    
    override open func placeSubViews() {
        super.placeSubViews()
        
        if let animationView = animationView, animationView.constraints.count == 0 {
            if let stateLabel = stateLabel, !stateLabel.isHidden {
                let width = (frame.width - stateLabel.textWidth) * 0.5 - labelInsetLeft
                animationView.frame = .init(x: 0, y: 0, width: width, height: frame.height)
                animationView.contentMode = .right
            } else {
                animationView.contentMode = .center
                animationView.frame = bounds
            }
        }
    }

    // MARK: - Do On State
    
    override open func doOnRefreshing(with oldState: State) {
        super.doOnRefreshing(with: oldState)
        
        startAnimating()
    }
    
    override open func doOnIdle(with oldState: State) {
        super.doOnIdle(with: oldState)
        
        stopAnimating()
    }

    override open func doOnNoMoreData(with oldState: State) {
        super.doOnNoMoreData(with: oldState)
        
        stopAnimating()
    }
}

// MARK: - Public

extension ZVRefreshAutoAnimationFooter {
    
    public  func setImages(_ images: [UIImage], for state: State) {
        setImages(images, duration: Double(images.count) * 0.1, for: state)
    }
    
    public func setImages(_ images: [UIImage], duration: TimeInterval, for state: State) {
        
        guard images.count > 0 else { return }
        
        if stateImages == nil { stateImages = [:] }
        if stateDurations == nil { stateDurations = [:] }
        
        stateImages?[state] = images
        stateDurations?[state] = duration
        if let image = images.first, image.size.height > frame.height {
            frame.size.height = image.size.height
        }
    }
    
    public func startAnimating() {
        
        guard let images = stateImages?[.refreshing], images.count > 0 else { return }
        
        animationView?.stopAnimating()
        
        if images.count == 1 {
            animationView?.image = images.last
        } else {
            animationView?.animationImages = images
            animationView?.animationDuration = stateDurations?[.refreshing] ?? 0.0
            animationView?.startAnimating()
        }
    }
    
    public func stopAnimating() {
        animationView?.stopAnimating()
    }
}

// MARK: - Private

extension ZVRefreshAutoAnimationFooter {
    
    func pullAnimation(with pullPercent: CGFloat) {
        
        guard let images = stateImages?[.idle], images.count > 0, refreshState == .idle else { return }
        
        animationView?.stopAnimating()
        
        var idx = Int(CGFloat(images.count) * pullingPercent)
        if idx >= images.count { idx = images.count - 1 }
        animationView?.image = images[idx]
        
        if pullingPercent > 1.0 {
            startAnimating()
        }
    }
}

