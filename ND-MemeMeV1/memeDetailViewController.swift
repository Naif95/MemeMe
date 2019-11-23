//
//  memeDetailViewController.swift
//  ND-MemeMeV1
//
//  Created by Naif on 20/10/2019.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class memeDetailViewController: UIViewController {

    var meme: Meme!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        imageView.image = meme.memedImage
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
