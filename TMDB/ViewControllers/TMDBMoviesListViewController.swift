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
       fetchMoviesList()
       
    }
   
    func fetchMoviesList() {
        viewModel.fetchMovies { withResponse, successStatus in
            dataSource = withResponse
        } failureBlock: { withResponse, failureStatus in
            //wait for update
        }
    }
    
}

extension TMDBMoviesListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
    
    
}

