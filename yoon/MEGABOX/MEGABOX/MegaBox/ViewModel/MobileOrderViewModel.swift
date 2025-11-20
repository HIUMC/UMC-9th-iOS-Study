//
//  MobileOrderViewModel.swift
//  MEGABOX
//
//  Created by 정승윤 on 11/19/25.
//

import Foundation
import Observation

@Observable
final class MobileOrderViewModel {

    let recommendedMenus: [MenuItemModel] = [
        MenuItemModel(menuImage: "lovecombo", name: "러브 콤보", price: 10900, isBest: true, isRecommended: true,discount:nil, isSoldOut: false),
        MenuItemModel(menuImage: "doublecombo", name: "더블 콤보", price: 24900, isBest: true, isRecommended: true,discount:nil, isSoldOut: false),
        MenuItemModel(menuImage: "disneyposter", name: "디즈니 픽사 포스터", price: 15900, isBest: false, isRecommended: true,discount:nil,isSoldOut: false)
    ]

    let bestMenus: [MenuItemModel] = [
        MenuItemModel(menuImage: "singlecombo", name: "싱글 콤보", price: 10900,isBest: true, isRecommended: false,discount:nil, isSoldOut: false),
        MenuItemModel(menuImage: "doublecombo", name: "더블 콤보", price: 24900, isBest: true, isRecommended: false,discount:nil, isSoldOut: false),
        MenuItemModel(menuImage: "lovecombopackage", name: "러브 콤보 패키지", price: 32000, isBest: false, isRecommended: false,discount:nil, isSoldOut: false)
    ]
    
    let menus: [MenuItemModel] = [
           MenuItemModel(menuImage: "singlecombo", name: "싱글 콤보", price: 10900, isBest: true, isRecommended: false,discount:nil, isSoldOut: false),
           MenuItemModel(menuImage: "lovecombo", name: "러브 콤보", price: 10900, isBest: true, isRecommended: false,discount:nil, isSoldOut: false),
           MenuItemModel(menuImage: "doublecombo", name: "더블 콤보", price: 24900, isBest: true, isRecommended: false,discount:nil, isSoldOut: false),
           MenuItemModel(menuImage: "lovecombopackage", name: "러브 콤보 패키지", price: 32900, isBest: false, isRecommended: false,discount:nil, isSoldOut: false),
           MenuItemModel(menuImage:"familycombo",name:"패밀리 콤보 패키지",price:47000,isBest:false,isRecommended:false,discount:nil,isSoldOut:false),
           MenuItemModel(menuImage:"ticketbook",name:"메가박스 오리지널 티켓북 시즌4 돌비시네마 에디션 단품", price:10900,isBest:false,isRecommended:true,discount:nil,isSoldOut:false),
           MenuItemModel(menuImage: "disneyposter", name: "디즈니 픽사 포스터", price: 15900, isBest: false, isRecommended: false,discount:nil, isSoldOut: true),
           MenuItemModel(menuImage:"insideout2",name:"인사이다드 아웃 2 감정", price:35900,isBest:false,isRecommended:false,discount:6000,isSoldOut:false)
           ]
}
