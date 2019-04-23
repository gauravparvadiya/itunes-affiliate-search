//
//  Albums.swift
//  iTunesAffiliate
//
//  Created by Gaurav Parvadiya on 2019-04-17.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import Foundation

struct AlbumResult: Codable {
    let resultCount: Int?
    let results: [Album]?
}

struct Album: Codable {
    let artistId: Int
    let artistName: String?
    let artistViewUrl: String?
    let artworkUrl100: String?
    let collectionArtistId: Int?
    let collectionArtistName: String?
    let collectionId: Int
    let collectionName: String?
    let collectionPrice: Float?
    let collectionViewUrl: String?
    let copyright: String?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    let releaseDate: String?
    let wrapperType: String?
}

func convertDateInFormat(text: String) -> String {
    if text != "" {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: text)!
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        return dateString
    } else {
        return ""
    }
}
