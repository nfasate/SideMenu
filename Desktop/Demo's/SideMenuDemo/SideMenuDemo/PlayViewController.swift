//
//  PlayViewController.swift
//  SideMenuDemo
//
//  Created by Nilesh's MAC on 9/29/17.
//  Copyright © 2017 Nilesh's MAC. All rights reserved.
//

import UIKit

class PlayViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        self.title = "Play"
    }

    @IBAction func goBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
