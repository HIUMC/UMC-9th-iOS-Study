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
                    Button( action: { viewModel.selectedTheater = theater } ) {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 55, height: 35)
                            .foregroundStyle( viewModel.selectedTheater == theater ? .purple03 : .gray01 )
                            .overlay(Text(theater.name)
                                .font(.PretendardSemiBold(size: 16))
                                .foregroundStyle( viewModel.selectedTheater == theater ? .white : .gray05) )
                    }
                    
                }
                
                Spacer()
            }
        }
        
    }
}

#Preview {
    SelectTheaterView(viewModel: BookingViewModel())
}
