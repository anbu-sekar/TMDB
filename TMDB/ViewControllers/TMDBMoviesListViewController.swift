//
//  TMDBMoviesListViewController.swift
//  TMDB
//
//  Created by Anbusekar Murugesan on 20/02/2022.
//

import Foundation
import UIKit
import Alamofire

class TMDBMoviesListViewController: TMDBViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var viewModel: TMDBViewModel = TMDBViewModel(Movies: TMDBMoviesListModel())
    var panGesture: UIGestureRecognizer!
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Custom methods
    
    override func customiseUI() {
        super.customiseUI()
        moviesCollectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        moviesCollectionView.register(UINib(nibName: "MoviesWithTitleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MoviesWithTitleCollectionViewCell.identifier)
        fetchMoviesList()
    }
    
    
    func fetchMoviesList(page: Int = 1) {
        viewModel.fetchMovies(page: page) { withResponse, successStatus in
            if self.viewModel.dataSource == nil {
                self.viewModel.dataSource = withResponse
            } else {
                self.viewModel.dataSource?.results!.append(contentsOf: withResponse.results!)
                self.viewModel.dataSource?.page = withResponse.page
            }
            self.moviesCollectionView.reloadData()
        } failureBlock: { withResponse, failureStatus in
            // noting on it
        }
    }
    
    func filterSearchResults(withText: String) {
        if withText.isEmpty == false {
            viewModel.searchedmovies = viewModel.dataSource?.results?.filter { list in
                return ((list.title.lowercased().contains(withText.lowercased())) || (list.originalTitle.lowercased().contains(withText.lowercased())))
            }
        }
        viewModel.searchedmovies = withText.isEmpty ? nil : viewModel.searchedmovies
        moviesCollectionView.reloadData()
    }
    
}

extension TMDBMoviesListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.moviesList[indexPath.row].voteAverage > 7 {
            if let cell: MoviesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath) as? MoviesCollectionViewCell {
                cell.updateCell(with: viewModel.moviesList[indexPath.row], at: indexPath)
                cell.delegate = self
                return cell
            }
        } else {
            if let cell: MoviesWithTitleCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesWithTitleCollectionViewCell.identifier, for: indexPath) as? MoviesWithTitleCollectionViewCell {
                cell.updateCell(indexPath: indexPath, with: viewModel.moviesList[indexPath.row])
                cell.delegate = self
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let movies = viewModel.dataSource?.results?[indexPath.row] {
            if movies.voteAverage > 7 {
                return CGSize(width: collectionView.frame.width, height: (collectionView.frame.width*0.55))
            } else {
                return CGSize(width: collectionView.frame.width, height: (collectionView.frame.width-100))
            }
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if ((viewModel.dataSource?.results?.count ?? 0)-3) == indexPath.row {
            fetchMoviesList(page: (viewModel.dataSource?.page ?? 0) + 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let str = UIStoryboard(name: "Main", bundle: nil)
        let vc = str.instantiateViewController(withIdentifier: "TMDBMoviewDetailViewController") as! TMDBMoviewDetailViewController
        
        vc.modalPresentationStyle = .popover
        if let movies = URL(string: "\(moviePostBaseUrl)\(viewModel.moviesList[indexPath.row].posterPath)") {
            vc.posterUrl = movies
        }
        
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
}

extension TMDBMoviesListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterSearchResults(withText: searchText)
    }
    
}

extension TMDBMoviesListViewController: MoviesWithTitleCollectionViewCellDelegate, MoviesCollectionViewCellDelegate {
    
    func didPressDeleteButton(at indexPath: IndexPath) {
        self.viewModel.dataSource?.results?.remove(at: indexPath.row)
        moviesCollectionView.performBatchUpdates {
            moviesCollectionView.deleteItems(at: [indexPath])
        } completion: { Status in

        }
    }
    
}
