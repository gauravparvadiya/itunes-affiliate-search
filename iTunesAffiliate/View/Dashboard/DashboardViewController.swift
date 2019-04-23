//
//  DashboardViewController.swift
//  iTunesAffiliate
//
//  Created by Gaurav Parvadiya on 2019-04-17.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import UIKit
import SDWebImage

class DashboardViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var AlbumTableView: UITableView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var generLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var popupView: UIView!
    
    var viewModel: DashboardViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData(text: "")
        searchBar.delegate = self
    }
    
    @IBAction func didTapClosePopup(_ sender: Any) {
        popupView.isHidden = true
    }
}

extension DashboardViewController {
    func setupUI() {
        self.title = "Search"
        AlbumTableView.delegate = self
        AlbumTableView.dataSource = self
        AlbumTableView.tableFooterView = UIView()
    }
    
    func getData(text: String) {
        viewModel?.searchAlbum(text: text) {
            self.AlbumTableView.reloadData()
        }
    }
    
    func showPopup(album: Album) {
        popupView.isHidden = false
        
        albumName.text = album.collectionName
        priceLabel.text = "\(album.collectionPrice ?? 0) \(album.currency ?? "USD")"
        copyrightLabel.text = album.copyright
    }
}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.albums.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell") as? AlbumTableViewCell, let albums = viewModel?.albums else {
            return UITableViewCell()
        }
        cell.tag = indexPath.row
        cell.configureCell(album: albums[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let album = viewModel?.albums[indexPath.row] else {
            return
        }
        searchBar.endEditing(true)
        showPopup(album: album)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

extension DashboardViewController: UISearchBarDelegate, UISearchDisplayDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getData(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}
