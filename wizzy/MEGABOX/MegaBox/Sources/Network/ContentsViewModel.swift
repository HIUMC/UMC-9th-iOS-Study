//
//  ContentsViewModel.swift
//  MegaBox
//
//  Created by 이서현 on 11/12/25.
//


import Foundation
import Moya

@Observable
class ContentsViewModel {
    var nowPlaying: NowPlayingResponse?
    var movieCards: [MovieModel] = []
    var movieDetails: [MovieDetailModel] = []
    let provider: MoyaProvider<UserRouter>
    
    init() {
        let logger = NetworkLoggerPlugin(configuration: .init(logOptions: [.verbose]))
        self.provider = MoyaProvider<UserRouter>(plugins: [logger])
    }
    
    @MainActor
    func getNowPlayingMovie(language: String, page: Int, region: String) async {
        do {
            let response = try await provider.requestAsync(.getMovie(language: language, page: page, region: region))
            let decoded = try JSONDecoder().decode(NowPlayingResponse.self, from: response.data)
            self.nowPlaying = decoded
            // map -> 화면용 모델들
            self.movieCards = decoded.results.map { $0.toModel() }
            self.movieDetails = decoded.results.map { $0.toDetailModel() }
        } catch {
            print("[getNowPlayingMovie] request/decode error:", error)
        }
    }
}
