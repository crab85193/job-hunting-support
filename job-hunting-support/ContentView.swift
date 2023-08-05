//
//  ContentView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("user_name") var name = ""
    @State var year = 0
    @State var tabSelect = 2
    
    @EnvironmentObject var sharedData: SharedData
    
    var body: some View {
        NavigationView{
            TabView(selection: $tabSelect){
                CompanyListView()
                    .tabItem{Image(systemName: "list.dash")
                    Text("List")
                    }
                    .tag(0)
                ScheduleView()
                    .tabItem{Image(systemName: "calendar")
                    Text("Schedule")
                    }
                    .tag(1)
                SelectionInfoView()
                    .tabItem{Image(systemName: "doc.text")
                    Text("SelectionInfo")
                    }
                    .tag(2)
                InternView()
                    .tabItem{Image(systemName: "figure.walk")
                    Text("Intern")
                    }
                    .tag(3)
                ProfileView()
                    .tabItem{Image(systemName: "person.fill")
                    Text("Profile")
                    }
                    .tag(4)
                /*  これは、カテゴリー別に表示する段階まできたら追加する。
                HomeView()
                    .tabItem{Image(systemName: "house.fill")
                    Text("Home")
                    }
                    .tag(1)
                */
            }
            .padding()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
