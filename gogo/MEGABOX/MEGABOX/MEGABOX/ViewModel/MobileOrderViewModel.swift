//
//  MobileOrderViewMOdel.swift
//  MEGABOX
//
//  Created by 고석현 on 11/15/25.
//

import Foundation
import Observation

@Observable
final class MobileOrderViewModel {

    // MARK: - 추천 메뉴
    let recommendedMenus: [MenuItemModel] = [
        MenuItemModel(imageName: "recommend1", title: "러브 콤보", price: 10900, isBest: true, isRecommended: true, isSoldOut: false),
        MenuItemModel(imageName: "recommend2", title: "더블 콤보", price: 24900, isBest: true, isRecommended: true, isSoldOut: false),
        MenuItemModel(imageName: "recommend3", title: "디즈니 픽사 포스터", price: 15900, isBest: false, isRecommended: true, isSoldOut: false)
    ]

    // MARK: - 베스트 메뉴
    let bestMenus: [MenuItemModel] = [
        MenuItemModel(imageName: "best1", title: "싱글 콤보", price: 10900, isBest: true, isRecommended: false, isSoldOut: false),
        MenuItemModel(imageName: "best2", title: "더블 콤보", price: 24900, isBest: true, isRecommended: false, isSoldOut: false),
        MenuItemModel(imageName: "best3", title: "러브 콤보 패키지", price: 32900, isBest: false, isRecommended: false, isSoldOut: false)
    ]
    
    // MARK: - 상세 메뉴 전체
    let menus: [MenuItemModel] = [
        MenuItemModel(imageName: "best1", title: "싱글 콤보", price: 10900, isBest: true, isRecommended: false, isSoldOut: false),
        MenuItemModel(imageName: "recommend1", title: "러브 콤보", price: 10900, isBest: true, isRecommended: false, isSoldOut: false),
        MenuItemModel(imageName: "recommend2", title: "더블 콤보", price: 24900, isBest: true, isRecommended: false, isSoldOut: false),
        MenuItemModel(imageName: "best3", title: "러브 콤보 패키지", price: 32900, isBest: false, isRecommended: false, isSoldOut: false),
        MenuItemModel(imageName:"best4",title:"패밀리 콤보 패키지",price:47000,isBest:false,isRecommended:false,isSoldOut:false),
        MenuItemModel(imageName:"ticketbook",title:"메가박스 오리지널 티켓북 시즌4 돌비시네마 에디션 단품", price:10900,isBest:false,isRecommended:true,isSoldOut:false),
        MenuItemModel(imageName: "recommend3", title: "디즈니 픽사 포스터", price: 15900, isBest: false, isRecommended: false, isSoldOut: true),
        MenuItemModel(imageName:"insideout",title:"인사이다드 아웃 2 감정", price:29900,isBest:false,isRecommended:false,isSoldOut:false)
        ]
        
}
