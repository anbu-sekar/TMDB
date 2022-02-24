//
//  MoviesCollectionViewCell.swift
//  TMDB
//
//  Created by Anbusekar Murugesan on 20/02/2022.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class MoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var MoviesImageView: UIImageView!
    
    static let identifier = "MoviesCollectionViewCell"
    
    
    // MARK: - Init methods
    
    override class func awakeFromNib() {
        super.awakeFromNib()

    }

  
    
    func updateCell(with movies: Movies) {
        MoviesImageView.layer.cornerRadius = 5
        if let backdropPath = movies.backdropPath {
            if let imageUrl = URL(string: (backdropBaseUrl+"\(backdropPath)")) {
                MoviesImageView.af.setImage(withURL: imageUrl)
            }
        }
        
    }
   
    
}
