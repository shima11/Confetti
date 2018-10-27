//
//  ViewController.swift
//  Confetti
//
//  Created by jinsei shima on 2018/10/27.
//  Copyright © 2018 jinsei shima. All rights reserved.
//

import UIKit

class ViewController : UIViewController {
    
    let button = ConfettiButton(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        button.setImage(UIImage(named: "sub1"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.center = view.center
        
        button.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        
        view.addSubview(button)
    }
    
    @objc func didTapButton() {
        button.likeBounce(0.8)
        button.animate()
    }
}
