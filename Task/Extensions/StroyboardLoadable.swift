//
//  StroyboardLoadable.swift
//  Task
//
//  Created by Hemalatha K on 22/07/21.
//  Copyright © 2021 HackerFactory. All rights reserved.
//

import UIKit

public protocol StoryboardLoadable {
    static var storyboardName: String { get }
}

public extension StoryboardLoadable where Self: UIViewController {
    static var storyboardName: String {
        return String(describing: Self.self)
    }
    
    static func initFromStoryBoard() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: .main)
        let viewController: Self = storyboard.makeInitialVC()
        return viewController
    }
}

extension UIStoryboard {
    func makeInitialVC<T: UIViewController>() -> T {
        guard let vc = instantiateInitialViewController() as? T else {
            fatalError("VC is not initial VC")
        }
        
        return vc
    }
}
extension UIViewController: StoryboardLoadable {}


public protocol NibLoadable: class {
    static var nibName: String { get }
}


public extension NibLoadable where Self: UIView {

    static var nibName: String {
        return String(describing: Self.self)
    }

     static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }

     static func fromNib() -> Self {
        guard let anyObjects = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil),
            let object = anyObjects[0] as? Self else {
                fatalError()
        }
        return object
    }

}
