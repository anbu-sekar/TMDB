//
//  TMDBMoviewDetailViewController.swift
//  TMDB
//
//  Created by Anbusekar Murugesan on 24/02/2022.
//

import Foundation
import UIKit
import AlamofireImage

class TMDBMoviewDetailViewController: TMDBViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    
    var posterUrl: URL?
    // MARK: - View life cycle methods
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func customiseUI() {
        super.customiseUI()
        guard let imageUrl = posterUrl else {return}
        detailImage.af.setImage(withURL: imageUrl)
    }
    
    @IBAction func dismissPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
