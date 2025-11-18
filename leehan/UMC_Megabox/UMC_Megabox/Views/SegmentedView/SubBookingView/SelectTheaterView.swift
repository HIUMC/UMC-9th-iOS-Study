//
//  SelectTheaterView.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/6/25.
//

import SwiftUI

struct SelectTheaterView: View {
    @ObservedObject var viewModel: BookingViewModel
    
    var body: some View {
        
        if (!viewModel.availableTheaters.isEmpty) {
            HStack(spacing: 8) {
                ForEach(viewModel.availableTheaters) { theater in
                    Button( action: { toggleTheaterSelection(theater) } ) {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 55, height: 35)
                            .foregroundStyle( viewModel.selectedTheaters.contains(theater) ? .purple03 : .gray01 )
                            .overlay(Text(theater.name)
                                .font(.PretendardSemiBold(size: 16))
                                .foregroundStyle( viewModel.selectedTheaters.contains(theater) ? .white : .gray05) )
                    }
                }
                
                Spacer()
            }
        }
        
    }
    
    private func toggleTheaterSelection(_ theater: Theater) {
        if let index = viewModel.selectedTheaters.firstIndex(of: theater) {
            viewModel.selectedTheaters.remove(at: index)
        } else {             
            viewModel.selectedTheaters.append(theater)
        }
    }
    
}

#Preview {
    SelectTheaterView(viewModel: BookingViewModel())
}
