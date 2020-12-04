//
//  ModalHelpers.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 12/11/2020.
//

//  https://medium.com/@shamiulcse.pust/present-transparent-modal-view-in-swiftui-5b5c4e459a44

import SwiftUI
import UIKit

private struct ViewControllerHolder {
    
    weak var value: UIViewController?
}

private struct ViewControllerKey: EnvironmentKey {
    
    static var defaultValue: ViewControllerHolder {
        return ViewControllerHolder(value: UIApplication.shared.windows.first?.rootViewController)
    }
}

extension EnvironmentValues {
    
    var rootViewController: UIViewController? {
        get { return self[ViewControllerKey.self].value }
        set { self[ViewControllerKey.self].value = newValue }
    }
}

extension UIViewController {
    
    func present<Content: View>(style: UIModalPresentationStyle = .automatic, transitionStyle: UIModalTransitionStyle = .coverVertical, @ViewBuilder builder: () -> Content) {
        let toPresent = UIHostingController(rootView: AnyView(EmptyView()))
        toPresent.modalPresentationStyle = style
        toPresent.modalTransitionStyle = transitionStyle
        toPresent.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        toPresent.rootView = AnyView(
            builder()
                .environment(\.rootViewController, toPresent)
        )
        self.view.addGestureRecognizer(UIGestureRecognizer { recognizer in
            print("tapped")
            
            self.dismiss(animated: true)
        })
        self.present(toPresent, animated: true, completion: nil)
    }
}
