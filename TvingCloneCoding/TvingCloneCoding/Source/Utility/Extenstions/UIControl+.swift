//
//  UIControl+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/04/27.
//
import UIKit.UIControl

extension UIControl {
    func addButtonAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping (_ sender: UIButton) -> ()) {
        @objc class ClosureSleeve: NSObject {
            let closure: (UIButton) -> ()
            
            init(_ closure: @escaping (UIButton) -> ()) {
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
