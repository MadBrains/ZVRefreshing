//
//  ZRefreshAutoAnimationFooter.swift
//
//  Created by ZhangZZZZ on 16/4/1.
//  Copyright © 2016年 ZhangZZZZ. All rights reserved.
//

import UIKit

open class ZVRefreshAutoAnimationFooter: ZVRefreshAutoStateFooter {
    
    // MARK: - Property
    
    private(set) lazy var animationView: UIImageView = {
        let animationView = UIImageView()
        animationView.backgroundColor = .clear
        return animationView
    }()
    
    private var _stateImages: [State: [UIImage]] = [:]
    private var _stateDurations: [State: TimeInterval] = [:]
    
    // MARK: getter & setter
    
    open override var refreshState: State {
        get {
            return super.refreshState
        }
        set {
            guard checkState(newValue).isIdenticalState == false else { return }
            super.refreshState = newValue
        }
    }
    
    // MARK: - Subviews
    
    override open func prepare() {
        super.prepare()
        if animationView.superview == nil {
            addSubview(animationView)
        }
    }
    
    override open func placeSubViews() {
        super.placeSubViews()
        
        if animationView.constraints.count > 0 { return }
        animationView.frame = bounds
        if stateLabel.isHidden {
            animationView.contentMode = .scaleAspectFit
        } else {
            animationView.contentMode = .scaleAspectFit
            animationView.frame.size.width = frame.size.width * 0.5 - 90
        }
    }

    // MARK: - Do On
    
    override open func doOn(refreshing oldState: State) {
        super.doOn(refreshing: oldState)
        
        guard let images = _stateImages[.refreshing], images.count > 0 else { return }
        
        animationView.stopAnimating()
        animationView.isHidden = false
        
        if images.count == 1 {
            animationView.image = images.last
        } else {
            animationView.animationImages = images
            animationView.animationDuration = _stateDurations[.refreshing] ?? 0.0
            animationView.startAnimating()
        }
    }
    
    override open func doOn(noMoreData oldState: State) {
        super.doOn(noMoreData: oldState)
        
        animationView.stopAnimating()
        animationView.isHidden = false
    }
    
    override open func doOn(idle oldState: State) {
        super.doOn(idle: oldState)
        
        animationView.stopAnimating()
        animationView.isHidden = false
    }
}

// MARK: - Public

extension ZVRefreshAutoAnimationFooter {
    
    /// 为相应状态设置图片
    public func setImages(_ images: [UIImage], state: State) {
        setImages(images, duration: Double(images.count) * 0.1, state: state)
    }
    
    /// 为相应状态设置图片
    public func setImages(_ images: [UIImage], duration: TimeInterval, state: State){
        
        guard images.count > 0 else { return }
        
        _stateImages[state] = images
        _stateDurations[state] = duration
        guard let image = images.first, image.size.height < frame.size.height else { return }
        frame.size.height = image.size.height
    }
}

