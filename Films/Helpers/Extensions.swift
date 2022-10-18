//
//  Extensions.swift
//  Films
//
//  Created by apple on 13.10.2022.
//

import UIKit


//MARK: - Anchor
extension UIView {
    func anchor ( top: NSLayoutYAxisAnchor? = nil,
                  left: NSLayoutXAxisAnchor? = nil,
                  botton: NSLayoutYAxisAnchor? = nil,
                  right: NSLayoutXAxisAnchor? = nil,
                  paddingTop: CGFloat = 0,
                  paddingLeft: CGFloat = 0,
                  paddingBotton: CGFloat = 0,
                  paddingRight: CGFloat = 0,
                  width: CGFloat? = nil,
                  height: CGFloat? = nil){
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
            
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let botton = botton {
            bottomAnchor.constraint(equalTo: botton, constant: -paddingBotton).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    func centerX(inView view: UIView, constant: CGFloat = 0){
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
    }
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat = 0, constant: CGFloat = 0){
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        if let left = leftAnchor {
            anchor(left: left, paddingLeft: paddingLeft)
        }
    }
}


extension Notification.Name{
    static let internetDown = Notification.Name("internetDown")
}
