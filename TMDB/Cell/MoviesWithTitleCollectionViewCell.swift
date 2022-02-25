//
//  MoviesWithTitleCollectionViewCell.swift
//  TMDB
//
//  Created by Anbusekar Murugesan on 20/02/2022.
//

import Foundation
import UIKit

protocol MoviesWithTitleCollectionViewCellDelegate: AnyObject {
    func didPressDeleteButton(at indexPath: IndexPath)
}

class MoviesWithTitleCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var moviewDescription: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    static let identifier = "MoviesWithTitleCollectionViewCell"
    weak var delegate: MoviesWithTitleCollectionViewCellDelegate?
    var currentIndex: IndexPath?
    
    
    // MARK: - Init methods
    
    override class func awakeFromNib() {
        super.awakeFromNib()
      
    }

    func updateCell(indexPath: IndexPath, with movies: Movies) {
        currentIndex = indexPath
        if let imageUrl = URL(string: (backdropBaseUrl+"\(movies.posterPath)")) {
            movieImage.layer.cornerRadius = 5
            movieImage.af.setImage(withURL: imageUrl)
            movieTitle.text = movies.originalTitle
            moviewDescription.text = movies.overview
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        if let currentPosition = currentIndex {
            delegate?.didPressDeleteButton(at : currentPosition)
        }
    }
    

}
