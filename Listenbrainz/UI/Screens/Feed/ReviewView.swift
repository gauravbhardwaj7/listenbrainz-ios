//
//  ReviewView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 23/08/24.
//

import SwiftUI

struct ReviewView: View {
    let event: Event
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("Rating:")
                    .fontWeight(.bold)
                ForEach(0..<5) { index in
                    Image(systemName: index < (event.metadata.rating ?? 0) ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                }
            }
            Text(event.metadata.text ?? "")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .italic()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(colorScheme == .dark ? Color(.systemBackground).opacity(0.1) : Color.white)
        .cornerRadius(10)
        .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .leading)
        .padding(.top, 5)
    }
}
