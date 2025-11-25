//
//  TestView.swift
//  MEGABOX
//
//  Created by 고석현 on 10/6/25.
//

import SwiftUI

// MARK: - Enum 정의
enum Tabs: Hashable {
    case home
    case search
    case profile
    case settings
}

// MARK: - 메인 View
struct GlassTabTestView: View {
    @State private var selectedTab: Tabs = .home
    
    var body: some View {
        ZStack {
            // 배경
            LinearGradient(colors: [.black, .gray.opacity(0.6)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            // 탭 컨텐츠
            TabView(selection: $selectedTab) {
                
                // 홈 탭
                HomeTestView()
                    .tag(Tabs.home)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                
                // 검색 탭
                SearchTestView()
                    .tag(Tabs.search)
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                
                // 프로필 탭
                ProfileTestView()
                    .tag(Tabs.profile)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                
                // 설정 탭
                SettingsTestView()
                    .tag(Tabs.settings)
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
            .tint(.blue)
            
            // iOS 18 이상: Liquid Glass
           
        }
    }
}

// MARK: - 각 탭별 테스트 화면
struct HomeTestView: View {
    var body: some View {
        VStack {
            Image(systemName: "house.fill")
                .font(.system(size: 50))
            Text("Home Tab")
                .font(.title2)
        }
        .foregroundColor(.white)
    }
}

struct SearchTestView: View {
    var body: some View {
        VStack {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 50))
            Text("Search Tab")
                .font(.title2)
        }
        .foregroundColor(.white)
    }
}

struct ProfileTestView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.fill")
                .font(.system(size: 50))
            Text("Profile Tab")
                .font(.title2)
        }
        .foregroundColor(.white)
    }
}

struct SettingsTestView: View {
    var body: some View {
        VStack {
            Image(systemName: "gear")
                .font(.system(size: 50))
            Text("Settings Tab")
                .font(.title2)
        }
        .foregroundColor(.white)
    }
}

// MARK: - Preview
#Preview {
    GlassTabTestView()
}
