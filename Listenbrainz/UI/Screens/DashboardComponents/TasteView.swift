//
//  TasteView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 12/08/24.
//

import SwiftUI


struct TasteView: View {
    @ObservedObject var viewModel: DashboardViewModel

    var body: some View {
        VStack {
            Text("Loved Songs")
                .font(.headline)
            List(viewModel.lovedSongs, id: \.created) { feedback in
                TrackInfoView(item: feedback, onPinTrack: { feedback in
                    // Handle pin track action
                }, onRecommendPersonally: { feedback in
                    // Handle personal recommendation action
                }, onWriteReview: { feedback in
                    // Handle write review action
                })
            }

            Text("Hated Songs")
                .font(.headline)
            List(viewModel.hatedSongs, id: \.created) { feedback in
                TrackInfoView(item: feedback, onPinTrack: { feedback in
                    // Handle pin track action
                }, onRecommendPersonally: { feedback in
                    // Handle personal recommendation action
                }, onWriteReview: { feedback in
                    // Handle write review action
                })
            }
        }
        .onAppear {
            viewModel.getLovedAndHatedSongs(username: viewModel.userName)
        }
    }
}




extension Feedback: TrackMetadataProvider {
    var trackName: String? {
      trackMetadata?.trackName
    }

    var artistName: String? {
      trackMetadata?.artistName
    }

    var coverArtURL: URL? {
      if let caaID = trackMetadata?.mbidMapping?.caaID {
            return URL(string: "https://coverartarchive.org/release/\(caaID)/front")
        }
        return nil
    }

    var originURL: String? {
        // Assuming no direct equivalent in Feedback, return nil or use a placeholder if needed
        return nil
    }

    var recordingMbid: String? {
      trackMetadata?.mbidMapping?.caaReleaseMbid
    }

    var recordingMsid: String? {
        // Assuming no direct equivalent in Feedback, return nil or use a placeholder if needed
        return nil
    }

    var entityName: String? {
        // You can return a default value or a combination of trackName and artistName if entityName isn't explicitly available
      return "\(trackMetadata?.trackName) by \(trackMetadata!.artistName)"
    }
}
