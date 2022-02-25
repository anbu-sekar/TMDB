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

protocol MoviesCollectionViewCellDelegate: AnyObject {
    func didPressDeleteButton(at indexPath: IndexPath)
}

class MoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var MoviesImageView: UIImageView!
    
    static let identifier = "MoviesCollectionViewCell"
    var currentIndex: IndexPath?
    weak var delegate: MoviesCollectionViewCellDelegate?
    
    
    // MARK: - Init methods
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    
    func updateCell(with movies: Movies, at index: IndexPath) {
        currentIndex = index
        MoviesImageView.layer.cornerRadius = 5
        if let backdropPath = movies.backdropPath {
            if let imageUrl = URL(string: (backdropBaseUrl+"\(backdropPath)")) {
                MoviesImageView.af.setImage(withURL: imageUrl)
            }
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        if let currentPosition = currentIndex {
            delegate?.didPressDeleteButton(at: currentPosition)
        }
    }
    
}
