//
//  TVShowDetailsView.swift
//  Flick
//
//  Created by Haider Kazal on 13/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import UIKit

class TVShowDetailsView: BaseView<DefaultTVShowDetailsViewModel> {
    private let overviewCellReuseIdentifier = "\(TVShowDetailsOverviewTableViewCell.self)"
    private let castsCellReuseIdentifier = "\(TVShowDetailsCastsTableViewCell.self)"
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 44
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TVShowDetailsOverviewTableViewCell.self, forCellReuseIdentifier: overviewCellReuseIdentifier)
        tableView.register(TVShowDetailsCastsTableViewCell.self, forCellReuseIdentifier: castsCellReuseIdentifier)
        let headerView = TVShowDetailsHeaderView(with: viewModel)
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 300)
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func setupViews() {
        addSubview(tableView)
        
        viewModel.updateDetailsSection = { [weak self] in
            let indexSet = IndexSet(arrayLiteral: MovieDetailsSection.overview.rawValue)
            self?.tableView.reloadSections(indexSet, with: .automatic)
        }
        
        viewModel.updateCreditsSection = { [weak self] in
            let indexSet = IndexSet(integer: MovieDetailsSection.cast.rawValue)
            self?.tableView.reloadSections(indexSet, with: .automatic)
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

extension TVShowDetailsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfElements(in: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        precondition(MovieDetailsSection(rawValue: section) != nil, "Invalid section")
        let cellSection = MovieDetailsSection(rawValue: section)!
        return cellSection.title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        precondition(MovieDetailsSection(rawValue: indexPath.section) != nil, "Invalid section")
        let cellSection = MovieDetailsSection(rawValue: indexPath.section)!
        
        switch cellSection {
        case .overview:
            let cell = tableView.dequeueReusableCell(withIdentifier: overviewCellReuseIdentifier, for: indexPath) as! TVShowDetailsOverviewTableViewCell
            cell.configureWith(data: viewModel.briefDetails)
            return cell
            
        case .cast:
            let cell = tableView.dequeueReusableCell(withIdentifier: castsCellReuseIdentifier, for: indexPath) as! TVShowDetailsCastsTableViewCell
            guard let cast = viewModel.casts?[existAt: indexPath.item] else { return cell }
            cell.configureWith(data: cast)
            return cell
        }
    }
}

extension TVShowDetailsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}


private final class TVShowDetailsHeaderView: BaseView<DefaultTVShowDetailsViewModel> {
    private lazy var coverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var taglineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews() {
        addSubview(coverImage)
        addSubview(taglineLabel)
        
        coverImage.kf.indicatorType = .activity
        coverImage.kf.setImage(with: viewModel.briefDetails.backdropURL)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            coverImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            coverImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            coverImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            coverImage.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            taglineLabel.leadingAnchor.constraint(equalTo: coverImage.leadingAnchor, constant: 10),
            taglineLabel.trailingAnchor.constraint(equalTo: coverImage.trailingAnchor, constant: -10),
            taglineLabel.bottomAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: -10)
        ])
    }
}

private final class TVShowDetailsOverviewTableViewCell: BaseTableViewCell<TMDbDiscoverTVShow> {
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func configureWith(data: TMDbDiscoverTVShow) {
        overviewLabel.text = data.overview
    }
    
    override func setupView() {
        contentView.addSubview(overviewLabel)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}

private final class TVShowDetailsCastsTableViewCell: BaseTableViewCell<TMDbCast> {
    private lazy var rootView: DiscoverTableViewCellView = {
        let view = DiscoverTableViewCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupView() {
        super.setupView()
        rootView.setupView()
        contentView.addSubview(rootView)
        
    }
    
    override func setupConstraints() {
        super.setupView()
        rootView.setupConstraints()
        
        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: contentView.topAnchor),
            rootView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rootView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rootView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override func configureWith(data: TMDbCast) {
        rootView.titleLabel.text = data.name
        rootView.overviewLabel.text = "As: \(data.character)"
        rootView.posterImageView.kf.indicatorType = .activity
        rootView.posterImageView.kf.setImage(with: data.profilePictureURL)
    }
}

