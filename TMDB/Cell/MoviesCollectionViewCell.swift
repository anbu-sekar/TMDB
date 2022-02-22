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
    var image: URL?

    
    
    // MARK: - Init methods
    
    override class func awakeFromNib() {
        super.awakeFromNib()
      
    }

    func updateCell(with movies: Movies) {
        if let imageUrl = URL(string: (moviePostBaseUrl+"\(movies.posterPath)")) {
            MoviesImageView.af.setImage(withURL: imageUrl)
            
        }
    }
   
    
}
