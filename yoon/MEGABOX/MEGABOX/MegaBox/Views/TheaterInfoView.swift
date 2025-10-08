//
//  TheaterInfoView.swift
//  MEGABOX
//
//  Created by 정승윤 on 10/8/25.
//

import Foundation
import SwiftUI

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
    @ObservedObject var theaterVM: TheaterViewModel
    
    let availableTheaters: [String: [MovieTimeData]] = [
        "강남": [MovieTimeData(start: "10:00", end: "12:30", vacancy: 50, capacity: 60),
               MovieTimeData(start: "13:00", end: "15:30", vacancy: 30, capacity: 60)],
        "홍대": [MovieTimeData(start: "11:00", end: "13:30", vacancy: 20, capacity: 40),
               MovieTimeData(start: "13:00", end: "15:30", vacancy: 30, capacity: 60)]
        // 신촌은 없는 극장
    ]
    
    var body: some View {
        
        ForEach(Array(theaterVM.selectedTheater), id: \.id) { theater in
            VStack(alignment: .leading, spacing: 4) {
                Text(theater.name)
                    .font(.PretendardBold18)
                Spacer().frame(height:21)

                // 즉시 실행 클로저 사용
                let theaterHallName = { () -> String in
                    switch theater.name {
                    case "강남": return "크리클라이너 1관"
                    case "홍대": return "BTS관 (7층 1관 [Laser])"
                    default: return "상영관 정보 없음"
                    }
                }()

                Text(theaterHallName)
                    .font(.PretendardBold18)
                    .foregroundStyle(.black)
                
                Spacer().frame(height:21)
                
                if let times = availableTheaters[theater.name], !times.isEmpty {
                        HStack(spacing: 36) {
                            ForEach(times, id: \.start) { time in
                                MovieTime(start: time.start, end: time.end, vacancy: time.vacancy, capacity: time.capacity)
                                        }
                                    }
                } else {
                    Text("선택한 극장에 상영시간표가 없습니다")
                        .foregroundColor(.red)
                }
            }
            
           
           
            }
        }
    }
struct MovieTimeData {
    let start: String
    let end: String
    let vacancy: Int
    let capacity: Int
}

struct TheaterInfoView_Preview: PreviewProvider {
    static var previews: some View {
        TheaterInfoView(theaterVM: {
            let vm = TheaterViewModel()
            vm.selectedTheater = [TheaterModel(name: "강남"), TheaterModel(name: "홍대")]
            return vm
        }())
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
