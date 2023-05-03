//
//  Timer+.swift
//  TvingCloneCoding
//
//  Created by uiskim on 2023/05/04.
//

import UIKit

extension Timer {
    static func addCarouselTimerAction(timeInterval: TimeInterval, _ action: @escaping () -> Void) -> Timer {
        @objc class ClosureSleeve: NSObject {
            let closure: () -> ()
            
            init(_ closure: @escaping () -> ()) {
                self.closure = closure
            }
            
            @objc func action() {
                closure()
            }
        }
        let sleeve = ClosureSleeve(action)
        let timer = Timer.scheduledTimer(timeInterval: timeInterval, target: sleeve, selector: #selector(ClosureSleeve.action), userInfo: nil, repeats: true)
        objc_setAssociatedObject(self, "\(UUID())", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        
        return timer
    }
}
