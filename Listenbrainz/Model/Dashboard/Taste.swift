//
//  Taste.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 18/08/24.
//

import Foundation

struct Taste:Codable{
  let feedback:[Feedback]?
}

struct Feedback: Codable {
    let created: Int
    let score: Int
    let trackMetadata: TasteTrackMetadata
    let userID: String

    enum CodingKeys: String, CodingKey {
        case created
        case score
        case trackMetadata = "track_metadata"
        case userID = "user_id"
    }
}

struct TasteTrackMetadata: Codable {
    let artistName: String
    let mbidMapping: TasteMbidMapping?
    let releaseName, trackName: String

    enum CodingKeys: String, CodingKey {
        case artistName = "artist_name"
        case mbidMapping = "mbid_mapping"
        case releaseName = "release_name"
        case trackName = "track_name"
    }
}

struct TasteMbidMapping: Codable {
    let caaID: Int
    let caaReleaseMbid: String

    enum CodingKeys: String, CodingKey {
        case caaID = "caa_id"
        case caaReleaseMbid = "caa_release_mbid"
    }
}



