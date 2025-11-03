//
//  TheaterInfoView.swift
//  MEGABOX
//
//  Created by 정승윤 on 10/8/25.
//

import Foundation
import SwiftUI

struct MovieTimeData {
    let start: String
    let end: String
    let vacancy: Int
    let capacity: Int
}

struct MovieTime: View {
    let start: String
    let end: String
    let vacancy : Int
    let capacity : Int
    var body: some View {
        VStack{
            Text(start).font(.PretendardBold18)
            Spacer().frame(height:4)
            Text("~\(end)")
                .font(.Pretendardregular12)
                .foregroundStyle(.gray03)
            Text("\(vacancy) / \(capacity)")
                .font(.PretendardsemiBold14)
                .foregroundStyle(.gray03) // 기본 색
                .overlay(
                    Text("\(vacancy)")
                        .font(.PretendardsemiBold14)
                        .foregroundStyle(.purple03),
                    alignment: .leading
                ) // 오버레이로 색을 다르게 표시
        }.frame(width:75, height: 86)
        .background{RoundedRectangle(cornerRadius: 12).stroke(.gray02, lineWidth: 1)}
        
    }
}

struct TheaterInfoView: View {
    let showtimes: [TimeModel]  // MovieBookView에서 전달
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(showtimes, id: \.auditorium) { timeModel in
                VStack(alignment: .leading, spacing: 8) {
                    Text("상영관: \(timeModel.auditorium)")
                        .font(.PretendardBold18)
                    LazyVGrid(columns: columns, spacing:36){
                        ForEach(timeModel.showtimes, id: \.start) { show in
                            MovieTime(
                                start: show.start,
                                end: show.end,
                                vacancy: show.available,
                                capacity: show.total
                            )
                        }
                    }
                }
            }
        }
    }
}

struct TheaterInfoView_Preview: PreviewProvider {
    static var previews: some View {
        let sampleShowtimes: [TimeModel] = [
            TimeModel(auditorium: "크리클라이너 1관", format: "2D", showtimes: [
                ShowTimeModel(start: "10:00", end: "12:30", available: 50, total: 60),
                ShowTimeModel(start: "13:00", end: "15:30", available: 30, total: 60)
            ]),
            TimeModel(auditorium: "BTS관 (7층 1관 [Laser])", format: "2D", showtimes: [
                ShowTimeModel(start: "11:00", end: "13:30", available: 20, total: 40),
                ShowTimeModel(start: "14:00", end: "16:30", available: 10, total: 40)
            ])
        ]
        
        return TheaterInfoView(showtimes: sampleShowtimes)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
