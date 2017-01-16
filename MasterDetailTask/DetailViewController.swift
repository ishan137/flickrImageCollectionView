//
//  DetailViewController.swift
//  MasterDetailTask
//
//  Created by Ishan Baboota on 16/01/17.
//  Copyright © 2017 Ishan Baboota. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var picDescription: UILabel!
    @IBOutlet weak var picImage: UIImageView!
    @IBOutlet weak var picTitle: UILabel!
    @IBOutlet weak var CloseButton: UIBarButtonItem!
    
    // values retrieved from the master controller
    var retrievedTitle =  String()
    var retrievedImage = UIImage()
    var retrievedDescription = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Convert HTML to string using extension
        let DecodedDescription = String(htmlEncodedString: retrievedDescription)
        
        picImage.image = retrievedImage
        picTitle.text = retrievedTitle
        picDescription.text = DecodedDescription

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Close button to dismiss view
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
