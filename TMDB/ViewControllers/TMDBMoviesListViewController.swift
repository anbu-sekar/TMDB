//
//  TMDBMoviesListViewController.swift
//  TMDB
//
//  Created by Anbusekar Murugesan on 20/02/2022.
//

import Foundation
import UIKit
import Alamofire

class TMDBMoviesListViewController: TMDBViewController {

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var viewModel: TMDBViewModel = TMDBViewModel(Movies: TMDBMoviesListModel())
    var dataSource: TMDBMoviesList?
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Custom methods
    
    override func customiseUI() {
        super.customiseUI()
        moviesCollectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
       fetchMoviesList()
    }
   
    func fetchMoviesList() {
        viewModel.fetchMovies { withResponse, successStatus in
            self.dataSource = withResponse
            self.moviesCollectionView.reloadData()
        } failureBlock: { withResponse, failureStatus in
            //wait for update
        }
    }
    
}

extension TMDBMoviesListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: MoviesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath) as? MoviesCollectionViewCell {
            if let movies = dataSource?.results[indexPath.row] {
                cell.updateCell(with: movies)
            }
            return cell
        }
         return UICollectionViewCell()
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }
}

