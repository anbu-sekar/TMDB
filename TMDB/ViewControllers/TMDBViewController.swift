//
//  TMDBViewController.swift
//  TMDB
//
//  Created by Anbusekar Murugesan on 20/02/2022.
//

import Foundation
import UIKit

class TMDBViewController: UIViewController {

    
    // MARK: - View life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        customiseUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    
    // MARK: - Custom methods
    
    func customiseUI() {
        self.navigationController?.isNavigationBarHidden = true
    }

}
