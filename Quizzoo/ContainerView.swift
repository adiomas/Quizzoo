//
//  ContainerView.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 08/06/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//

import UIKit

class ContainerView: UIView {
    
    var scrollView : UIScrollView!
    
    override init(frame: CGRect) {
          super.init(frame : frame)
          buildViews()
          createConstraints()
 
      }
      
      required init?(coder: NSCoder) {
          super.init(coder: coder)
          buildViews()
          createConstraints()
      }
    
    
    
    func buildViews() {
        scrollView = UIScrollView()
        scrollView.isHidden = true
        scrollView.isScrollEnabled = false
        scrollView.backgroundColor = .white
        addSubview(scrollView)   
    }


func createConstraints() {
    scrollView.autoPinEdgesToSuperviewEdges()

}
    
func scroll(deltax: CGFloat) {
    scrollView.setContentOffset(CGPoint(x: deltax, y: 0), animated: true)
}

}
