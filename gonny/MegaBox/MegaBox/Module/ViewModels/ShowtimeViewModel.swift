//
//  ShowtimeViewModel.swift
//  MegaBox
//
//  Created by 박병선 on 10/30/25.
//
import Foundation

@MainActor
// 상영관별 상영시간 정보를 담은 JSON을 Encoing하는 기능을 담음
final class ShowtimeViewModel: ObservableObject {
    @Published var movies: [ShowtimeMovie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func fetchShowtimes() async {
        print(" fetchShowtimes() CALLED") //디버깅용
        isLoading = true
        errorMessage = nil

        // 1) 파일 찾기
        guard let url = Bundle.main.url(forResource: "MovieSchedule", withExtension: "json") else {
            let msg = " MovieShedule.json을 번들에서 찾을 수 없음 "
            print(msg) //디버깅용
            self.errorMessage = msg
            self.isLoading = false
            return
        }
        print("JSON URL:", url.lastPathComponent)

        do {
            let data = try Data(contentsOf: url)


            let response = try JSONDecoder().decode(ShowtimesResponse.self, from: data)
            print("decode OK. movies:", response.data.movies.count)

            let converted = response.data.movies.map { $0.toDomain() }
            self.movies = converted
            self.isLoading = false

            // 샘플 출력 (첫 영화/첫 날짜/첫 지역)
            if let m = converted.first {
                print(" sample title:", m.title)
                if let s = m.schedules.first {
                    print("sample date:", s.date)
                    if let a = s.areas.first {
                        print("sample area:", a.area, "items:", a.items.count)
                    }
                }
            }
        } catch {
            let msg = " JSON 디코딩 실패: \(error)"
            print(msg)
            self.errorMessage = msg
            self.isLoading = false
        }
    }
}
