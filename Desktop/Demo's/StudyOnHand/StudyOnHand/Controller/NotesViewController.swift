//
//  NotesViewController.swift
//  StudyOnHand
//
//  Created by Nilesh's MAC on 10/7/17.
//  Copyright © 2017 Nilesh's MAC. All rights reserved.
//

import UIKit
var frameSize:CGRect!
class NotesViewController: UIViewController {

    @IBOutlet weak var notesView: CTView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1
        guard let file = Bundle.main.path(forResource: "zombies", ofType: "txt") else { return }
        
        do {
            frameSize = notesView.frame
            let text = try String(contentsOfFile: file, encoding: .utf8)
            // 2
            let parser = MarkupParser()
            parser.parseMarkup(text)
            (view as? CTView)?.buildFrames(withAttrString: parser.attrString, andImages: parser.images)
            
            
        } catch _ {
        }
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
