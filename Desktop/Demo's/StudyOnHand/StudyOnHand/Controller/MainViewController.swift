//
//  ViewController.swift
//  StudyOnHand
//
//  Created by Nilesh's MAC on 10/7/17.
//  Copyright © 2017 Nilesh's MAC. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Initialize Configuration
        var configuration = Configuration()
        
        print(configuration.environment.baseURL)
        print(configuration.environment.token)
    }
    @IBAction func notesBtnTapped(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "NotesViewController") as! NotesViewController
        present(vc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

