//
//  MainViewController.swift
//  VKApp
//
//  Created by Ksusha on 21.02.2021.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func dismissBarButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        //self.dismiss(animated: true)
    }
    
    //@IBAction func dismissButtonPressed(_ sender: UIButton) {
        //self.dismiss(animated: true)
    //    navigationController?.popViewController(animated: true)
    //}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
