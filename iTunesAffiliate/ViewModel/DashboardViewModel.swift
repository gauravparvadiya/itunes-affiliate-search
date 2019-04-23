//
//  DashboardViewModel.swift
//  iTunesAffiliate
//
//  Created by Gaurav Parvadiya on 2019-04-17.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import Foundation

class DashboardViewModel {
    
    var albums: [Album] = []
    
    func searchAlbum(text: String, onSuccess: @escaping () -> Void) {
        Network.request(.fetchAlbum(text: text), decodeType: AlbumResult.self, success: { albums in
            self.albums = albums.results ?? []
            onSuccess()
        }, error: { _ in
            //
        }, failure: { _ in
            //
        }) {
            //
        }
    }
}
