//
//  StyleManager.swift
//  Style Playground

import UIKit

extension Notification.Name {
    static let didChangeTheme = Notification.Name("didChangeTheme")
}

@objc class StyleManager: NSObject {
    @objc public static let themeDefault = "default"
    @objc public static let themeVariant1 = "variant1"
    
    @objc class func setTheme(theme: String, viewController: UIViewController? = nil) {
        setTheme(theme: theme, viewController: viewController, force: false);
    }
    
    class func setTheme(theme: String, viewController: UIViewController? = nil, force: Bool = false) {
        if force || getTheme() != theme {
            UserDefaults(suiteName: "app_theme")?.set(theme, forKey: "theme")
            UserDefaults(suiteName: "app_theme")?.synchronize()
            
            print("setTheme: \(theme)")
            
            styleMe(theme: theme)
            
            rebuildTheme(viewController: viewController)
            
            NotificationCenter.default.post(name: .didChangeTheme, object: nil)
        }
    }
    
    @objc class func getTheme() -> String {
        guard let theme = UserDefaults(suiteName: "app_theme")?.value(forKey: "theme") else {
            setTheme(theme: themeDefault, force: true)
            return themeDefault;
        }
        
        return theme as! String
    }
    
    @objc class func isDefault() -> Bool {
        return getTheme() == themeDefault
    }
    
    // MARK: - Style Me!
    
    @objc class func styleMe(theme: String) {
        styleNavBar(theme: theme)
        styleLabel(theme: theme)
        styleTextField(theme: theme)
        styleTextView(theme: theme)
        styleAlertView(theme: theme)
        styleTabBar(theme: theme)
        styleSwitch(theme: theme)
    }
    
    @objc class func rebuildTheme(viewController: UIViewController? = nil) {
        let appDelegate = UIApplication.shared.delegate
        
        appDelegate?.window??.subviews.forEach({ (view: UIView) in
            view.removeFromSuperview()
            appDelegate?.window??.addSubview(view)
        })
        
        viewController?.view.setNeedsLayout()
        viewController?.view.setNeedsDisplay()
        
        viewController?.navigationController?
            .viewControllers.forEach({ (controller: UIViewController) in
                controller.view.setNeedsLayout()
                controller.view.setNeedsDisplay()
            })
    }
    
    // MARK: - Style UIViews
    
    @objc class func styleSwitch(theme: String) {
        UISwitch.appearance().onTintColor = colorLightAzure(theme: theme)
        UISwitch.appearance().thumbTintColor = colorAzure(theme: theme)
    }
    
    @objc class func styleNavBar(theme: String) {
        let navTintColor = colorBlue(theme: theme)
        let navContainedAppearance = UINavigationBar.appearance()
        navContainedAppearance.barTintColor = navTintColor
    }
    
    @objc class func styleTabBar(theme: String) {
        UITabBar.appearance().tintColor = colorAzure(theme: theme)
    }
    
    @objc class func styleLabel(theme: String) {
        UILabel.appearance().textColor = colorBlue(theme: theme)
    }
    
    @objc class func styleTextField(theme: String) {
        UITextField.appearance().tintColor = colorAzure(theme: theme)
        UITextField.appearance().textColor = colorAzure(theme: theme)
    }
    
    @objc class func styleTextView(theme: String) {
        UITextView.appearance().tintColor = colorAzure(theme: theme)
        UITextView.appearance().textColor = colorAzure(theme: theme)
    }
    
    // AlertViewController button color
    @objc class func styleAlertView(theme: String) {
        UIView.appearance(
            whenContainedInInstancesOf: [UIAlertController.self]
        ).tintColor = colorAzure(theme: theme)
    }
    
    // MARK: - Colors
    @objc class func controllerBackgroundTint() -> UIColor {
        if #available(iOS 12.0, *) {
            switch UIScreen.main.traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor(hex: "595858")
            default:
                return UIColor(hex: "EFF0F1")
            }
        } else {
            // Fallback on earlier versions
            return UIColor(hex: "EFF0F1")
        }
    }
    
    @objc class func colorLightAzure(theme: String) -> UIColor {
        return colors(defaultColor: "C5E1EF",
                      variantColor: "f7d77e",
                      forTheme: theme)
    }
    
    @objc class func colorAzure(theme: String) -> UIColor {
        return colors(defaultColor: "009EE0",
                      variantColor: "f5b402",
                      forTheme: theme)
    }
    
    @objc class func colorBlue(theme: String) -> UIColor {
        return colors(defaultColor: "0A306B",
                      variantColor: "a37802",
                      forTheme: theme)
    }
    
    fileprivate class func colors(defaultColor: String,
                                  variantColor: String,
                                  forTheme theme: String = themeDefault) -> UIColor {
        var color = UIColor(hex: defaultColor)
        
        switch theme {
        case themeVariant1:
            color = UIColor(hex: variantColor)
        default:
            print("colors: default")
        }
        return color
    }
}

