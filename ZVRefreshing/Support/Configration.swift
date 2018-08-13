//
//  Constrants.swift

//
//  Created by zevwings on 16/3/28.
//  Copyright © 2016年 zevwings. All rights reserved.
//

import UIKit

public typealias ZVRefreshHandler = () -> ()

typealias ZVReloadDataHandler = (_ totalCount: Int) -> ()

struct AnimationDuration {
    static let fast = 0.25
    static let slow = 0.4
}

struct ComponentHeader {
    static let height: CGFloat = 54.0
}

struct ComponentFooter {
    static let height: CGFloat = 44.0
}

struct ActivityIndicator {
    static let width = 24.0
}

extension Bundle {
    
    static var localizedBundle: Bundle? {
        let bundle = Bundle(for: ZVRefreshComponent.self)
        guard let path = bundle.path(forResource: "Localized", ofType: "bundle") else { return nil }
        return Bundle(path: path)
    }
}

extension UIImage {
    
    static var arrow: UIImage? {
        
        let bundle = Bundle(for: ZVRefreshComponent.self)
        guard let path = bundle.path(forResource: "Image", ofType: "bundle") else { return nil }
        guard let filePath = Bundle(path: path)?.path(forResource: "arrow@3x", ofType: "png") else { return nil }
        let image = UIImage(contentsOfFile: filePath)?.withRenderingMode(.alwaysTemplate)
        return image
    }
}
