//
//  ViewController.swift
//  DemoExample
//
//  Created by Nilesh's MAC on 10/28/17.
//  Copyright © 2017 Nilesh's MAC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ColorBlockViewDelegate {

    @IBOutlet weak var colorBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func colorBtnTapped(_ sender: UIButton) {
        //Display color block view on tap button
        let blockView = self.view.showColorBlockView(onTap: sender, with: 100)
        blockView.delegate = self
        //Set custom color
        blockView.setCustomColor(to: .down, color: .green)
        blockView.setCustomColor(to: .right, color: .blue)
        blockView.setCustomColor(to: .up, color: .yellow)
        blockView.setCustomColor(to: .left, color: .red)
    }
    
    @IBAction func colorBtnTapped1(_ sender: UIButton) {
        let blockView = self.view.showColorBlockView(onTap: sender, with: 100)
        blockView.delegate = self
        //Set custom color
        blockView.setCustomColor(to: .down, color: .green)
        blockView.setCustomColor(to: .right, color: .blue)
        blockView.setCustomColor(to: .up, color: .yellow)
        blockView.setCustomColor(to: .left, color: .red)
    }
    func colorBlockDidSelect(color: UIColor) {
        print("color: \(color)")
        colorBtn.backgroundColor = color
    }
    
    func colorBlockDidClose() {
        print("close")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

