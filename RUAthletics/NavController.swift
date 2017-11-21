//
//  NavController.swift
//  RUAthletics
//
//  Created by Praveen Sakthivel on 11/19/17.
//  Copyright © 2017 TBLE Technologies. All rights reserved.
//

import UIKit

class NavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.barTintColor = UIColor.init(red: 207/255, green: 16/255, blue: 45/255, alpha: 1)
        self.navigationBar.backgroundColor = UIColor.init(red: 207/255, green: 16/255, blue: 45/255, alpha: 1)
       // let border = CALayer()
        //border.backgroundColor = UIColor.init(red: 217/255, green: 180/255, blue: 74/255, alpha: 1).cgColor
       // border.frame = CGRect(x:0, y: self.navigationBar.frame.size.height-1, width:  self.navigationBar.frame.size.width, height:  1)
        //self.navigationBar.layer.addSublayer(border)
        //self.navigationBar.layer.masksToBounds = true
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "American Typewriter", size: 30)!, NSForegroundColorAttributeName: UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)]
        // Do any additional setup after loading the view.
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
