//
//  InternView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/05.
//
import SwiftUI

struct InternView: View {

    var body: some View {
        NavigationView{
            VStack{
                List{
                    Text("CompanyName")
                }
            }
            .navigationTitle("インターン")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: InternAddView()) {
                        Text("追加")
                    }
                }
            }
        }
    }
}

struct InternView_Previews: PreviewProvider {
    static var previews: some View {
        InternView()
    }
}
