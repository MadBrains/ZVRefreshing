//
//  Constrants.swift

//
//  Created by zevwings on 16/3/28.
//  Copyright © 2016年 zevwings. All rights reserved.
//

import UIKit

public typealias ZVRefreshHandler = () -> ()

internal typealias ZVReloadDataHandler = (_ totalCount: Int) -> ()

//MARK: - Constants

internal struct AnimationDuration {
    static let fast = 0.25
    static let slow = 0.4
}

internal struct ComponentHeader {
    static let height: CGFloat = 54.0
}

internal struct ComponentFooter {
    static let height: CGFloat = 44.0
}

internal struct ActivityIndicator {
    static let width = 24.0
}

// MARK: - Extension
// MARK: Bundle

extension Bundle {
    
    internal static var localizedBundle: Bundle? {
        let bundle = Bundle(for: ZVRefreshComponent.self)
        guard let path = bundle.path(forResource: "Localized", ofType: "bundle") else { return nil }
        return Bundle(path: path)
    }
}

// MARK: UIImage

extension UIImage {
    
    internal static var arrow: UIImage? {
        
        let bundle = Bundle(for: ZVRefreshComponent.self)
        guard let path = bundle.path(forResource: "Image", ofType: "bundle") else { return nil }
        guard let filePath = Bundle(path: path)?.path(forResource: "arrow@3x", ofType: "png") else { return nil }
        let image = UIImage(contentsOfFile: filePath)?.withRenderingMode(.alwaysTemplate)
        return image
    }
}

// MARK: UILabel

extension UILabel {
    
    internal class var `default`: UILabel {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 14.0)
        label.textColor = .lightGray
        label.autoresizingMask = .flexibleWidth
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }
    
    internal var textWidth: CGFloat {
        
        let size = CGSize(width: Int.max, height: Int.max)
        guard let text = self.text else { return 0 }
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading, .usesDeviceMetrics, .truncatesLastVisibleLine]
        let attributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: self.font]
        let width = (text as NSString).boundingRect(with: size, options: options, attributes: attributes, context: nil).size.width
        return width
    }
}

// MARK: NSObject

extension NSObject {
    
    internal class func exchangeInstanceMethod(m1: Selector, m2: Selector) {
        
        let method1 = class_getInstanceMethod(self, m1)
        let method2 = class_getInstanceMethod(self, m2)
        
        let didAddMethod = class_addMethod(self, m1, method_getImplementation(method2!), method_getTypeEncoding(method2!))
        
        if didAddMethod {
            class_replaceMethod(self, m2, method_getImplementation(method1!), method_getTypeEncoding(method1!))
        } else {
            method_exchangeImplementations(method1!, method2!)
        }
    }
}

//MARK: - Localization

struct LocalizedKey {
    
    struct State {
        static let lastUpdatedTime = "last update:"
        static let dateToday = "today"
        static let noLastTime = "no record"
    }
    
    struct Header {
        static let idle = "pull down to refresh"
        static let pulling = "release to refresh"
        static let refreshing = "loading..."
    }
    
    struct AutoFooter {
        static let idle = "tap or pull up to load more"
        static let refreshing = "loading..."
        static let noMoreData = "no more data"
    }
    
    struct BackFooter {
        static let idle = "pull up to load more"
        static let pulling = "release to load more"
        static let refreshing = "loading..."
        static let noMoreData = "no more data"
    }
}

func localized(string key: String, comment: String = "") -> String {
    
    guard let bundle = Bundle.localizedBundle else { return "" }
    
    var tableName = ""
    guard let language = Locale.preferredLanguages.first else { return "en"}
    if language.hasPrefix("zh-Hant") {
        tableName = "zh-Hant"
    } else if language.hasPrefix("zh-Hans") {
        tableName = "zh-Hans"
    } else {
        tableName = "en"
    }
    
    return NSLocalizedString(key, tableName: tableName, bundle: bundle, value: "", comment: comment.isEmpty ? key: comment)
}
