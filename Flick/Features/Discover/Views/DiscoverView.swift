//
//  DiscoverView.swift
//  Flick
//
//  Created by Haider Kazal on 12/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Kingfisher
import UIKit

final class DiscoverView: BaseView<DiscoverViewModel> {
    private let movieCellReuseIdentifier = "\(DiscoverMovieTableViewCell.self)"
    private let tvShowCellReuseIdentifier = "\(DiscoverTVShowTableViewCell.self)"
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 44
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.register(DiscoverMovieTableViewCell.self, forCellReuseIdentifier: movieCellReuseIdentifier)
        tableView.register(DiscoverTVShowTableViewCell.self, forCellReuseIdentifier: tvShowCellReuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    weak var coordinator: DiscoverCoordinator?
    
    override func setupViews() {
        addSubview(tableView)
        
        viewModel.updateMoviesUISection = { [weak self] in
            self?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
        
        viewModel.updateTVShowsUISection = { [weak self] in
            self?.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
        }
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension DiscoverView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfElements(in: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        precondition(DiscoverViewModelSection(rawValue: section) != nil, "Invalid section")
        let cellSection = DiscoverViewModelSection(rawValue: section)!
        return cellSection.title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        precondition(DiscoverViewModelSection(rawValue: indexPath.section) != nil, "Invalid section")
        
        let cellSection = DiscoverViewModelSection(rawValue: indexPath.section)!
        
        switch cellSection {
        case .movies:
            let cell = tableView.dequeueReusableCell(withIdentifier: movieCellReuseIdentifier, for: indexPath) as! DiscoverMovieTableViewCell
            let model = viewModel.moviesViewModel[indexPath.item].movie
            cell.configureWith(data: model)
            return cell
            
        case .tvShows:
            let cell = tableView.dequeueReusableCell(withIdentifier: tvShowCellReuseIdentifier, for: indexPath) as! DiscoverTVShowTableViewCell
            let model = viewModel.tvShowsViewModel[indexPath.item].tvShow
            cell.configureWith(data: model)
            return cell
        }
        
    }
}

extension DiscoverView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        precondition(DiscoverViewModelSection(rawValue: indexPath.section) != nil, "Invalid section")
        
        let cellSection = DiscoverViewModelSection(rawValue: indexPath.section)!
        
        switch cellSection {
        case .movies:
            let movie = viewModel.moviesViewModel[indexPath.item].movie
            coordinator?.showDetails(for: movie)
            
        case .tvShows:
            let tvShow = viewModel.tvShowsViewModel[indexPath.item].tvShow
            coordinator?.showDetails(for: tvShow)
        }
    }
}

extension DiscoverView: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let posterURLs = indexPaths.compactMap({ viewModel.tvShowsViewModel[existAt: $0.item]?.tvShow.posterURL })
        posterURLs.forEach({ KingfisherManager.shared.retrieveImage(with: $0, completionHandler: nil) })
        
        let backdropURLs = indexPaths.compactMap({ viewModel.tvShowsViewModel[existAt: $0.item]?.tvShow.backdropURL })
        backdropURLs.forEach({ KingfisherManager.shared.retrieveImage(with: $0, completionHandler: nil) })
    }
}
