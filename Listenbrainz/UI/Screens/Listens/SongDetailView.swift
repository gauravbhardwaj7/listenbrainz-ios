import SwiftUI

struct SongDetailView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject private var imageLoader = ImageLoader.shared
    @State private var isLoading = true
    @Environment(\.colorScheme) var colorScheme

    @State private var showPinTrackView = false
    @State private var showingRecommendToUsersPersonallyView = false
    @State private var selectedListen: Listen?
    @State private var isPresented:Bool = false
    @AppStorage(Strings.AppStorageKeys.userToken) private var userToken: String = ""
    @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""

    var body: some View {
        ZStack {
            colorScheme == .dark ? Color.backgroundColor : Color.white
            VStack {
                ScrollView {
                    ForEach(homeViewModel.listens, id: \.recordingMsid) { listen in
                        TrackInfoView(
                            item: listen,
                            onPinTrack: { event in
                                selectedListen = listen
                                showPinTrackView = true
                            },
                            onRecommendPersonally: { event in
                                selectedListen = listen
                                showingRecommendToUsersPersonallyView = true
                            }
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(colorScheme == .dark ? Color.black : Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    }
                }
            }
            .onAppear {
                Task {
                    await withTaskGroup(of: Void.self) { group in
                        for listen in homeViewModel.listens {
                            if let coverArtURL = listen.trackMetadata?.coverArtURL {
                                group.addTask {
                                    await imageLoader.loadImage(url: coverArtURL) { _ in }
                                }
                            }
                        }
                        await group.waitForAll()
                    }
                    isLoading = false
                }
            }
            .centeredModal(isPresented: $showPinTrackView) {
                if let listen = selectedListen {
                    PinTrackView(
                      isPresented: $isPresented,
                      item: listen,
                      userToken: userToken
                    )
                    .environmentObject(homeViewModel)
                }
            }
            .centeredModal(isPresented: $showingRecommendToUsersPersonallyView) {
                if let listen = selectedListen {
                    RecommendToUsersPersonallyView(item: listen, userName: userName, userToken: userToken)
                        .environmentObject(homeViewModel)
                }
            }

        }
    }
}


