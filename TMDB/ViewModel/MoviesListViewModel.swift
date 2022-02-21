//
//  MoviesListViewModel.swift
//  TMDB
//
//  Created by Anbusekar Murugesan on 20/02/2022.
//

import Foundation
import Alamofire




class TMDBViewModel {
    var model: MoviesListModel
    
    init(Movies: MoviesListModel) {
        self.model = MoviesListModel()
    }
    
    func fetchMovies(successBlock: @escaping MoviesListModelProtocol.SuccessBlock, failureBlock: @escaping MoviesListModelProtocol.FailureBlock) {
        model.MoviesList { withResponse, successStatus in
            successBlock(withResponse, successStatus)
        } failureBlock: { withResponse, failureStatus in
            failureBlock(withResponse, failureStatus)
        }
    }

}
