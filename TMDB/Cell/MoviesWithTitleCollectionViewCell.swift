//
//  MoviesWithTitleCollectionViewCell.swift
//  TMDB
//
//  Created by Anbusekar Murugesan on 20/02/2022.
//

import Foundation
import UIKit

class MoviesWithTitleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var moviewDescription: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    static let identifier = "MoviesWithTitleCollectionViewCell"
    
    // MARK: - Init methods
    
    override class func awakeFromNib() {
        super.awakeFromNib()
      
    }

    func updateCell(with movies: Movies) {
        if let imageUrl = URL(string: (moviePostBaseUrl+"\(movies.posterPath)")) {
            movieImage.layer.cornerRadius = 5
            movieImage.af.setImage(withURL: imageUrl)
            movieTitle.text = movies.originalTitle
            moviewDescription.text = movies.overview
        }
    }

}
