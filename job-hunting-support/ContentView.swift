//
//  ContentView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var name = ""
    @State var year = 0
    
    @State var tabSelect = 0
    
    var body: some View {
        NavigationView{
            TabView(selection: $tabSelect){
                ListView()
                    .tabItem{Image(systemName: "list.dash")
                    Text("List")
                    }
                    .tag(0)
                /*  これは、カテゴリー別に表示する段階まできたら追加する。
                HomeView()
                    .tabItem{Image(systemName: "house.fill")
                    Text("Home")
                    }
                    .tag(1)
                */
                ProfileView(name: name, year: year)
                    .tabItem{Image(systemName: "person.fill")
                    Text("Profile")
                    }
                    .tag(2)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
