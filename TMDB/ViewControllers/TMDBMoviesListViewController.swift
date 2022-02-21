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

    var viewModel: TMDBViewModel = TMDBViewModel(Movies: MoviesListModel())
    
    
   
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func customiseUI() {
        super.customiseUI()
        viewModel.fetchMovies { withResponse, successStatus in
            print(withResponse)
        } failureBlock: { withResponse, failureStatus in
            print(withResponse)
        }



    }
   
    
}
