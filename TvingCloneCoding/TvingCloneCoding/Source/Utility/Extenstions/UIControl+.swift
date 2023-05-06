//
//  UIControl+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/27.
//
import UIKit.UIControl

extension UIControl {
    func addButtonAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping ButtonAction) {
        @objc class ClosureSleeve: NSObject {
            let closure: ButtonAction
            
            init(_ closure: @escaping ButtonAction) {
                self.closure = closure
            }
            
            @objc func invoke(_ sender: UIButton) {
                closure(sender)
            }
        }
        
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke(_:)), for: controlEvents)
        objc_setAssociatedObject(self, "\(UUID())", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
