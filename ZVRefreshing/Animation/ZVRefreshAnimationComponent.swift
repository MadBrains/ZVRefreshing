//
//  ZVRefreshAnimationComponent.swift
//  ZVRefreshing
//
//  Created by 张伟 on 2018/8/13.
//  Copyright © 2018年 zevwings. All rights reserved.
//

import Foundation

// MARK: - Public

public protocol ZVRefreshAnimationComponent: AnyObject {
    
    var stateImages: [ZVRefreshComponent.State: [UIImage]]? { get set }
    var stateDurations: [ZVRefreshComponent.State: TimeInterval]? { get set }
    
    var animationView: UIImageView? { get }
}

public extension ZVRefreshAnimationComponent where Self: ZVRefreshComponent{
    
    public  func setImages(_ images: [UIImage], for state: ZVRefreshComponent.State) {
        setImages(images, duration: Double(images.count) * 0.1, for: state)
    }
    
    public func setImages(_ images: [UIImage], duration: TimeInterval, for state: ZVRefreshComponent.State) {
        
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

extension ZVRefreshAnimationComponent where Self: ZVRefreshComponent {
    
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
