//
//  FirstView.swift
//  job-hunting-support
//  
//  Created by 宮平保 on 2023/06/22
//  
//

import SwiftUI

//諸々のテスト用のView
struct FirstView: View {
    
    @State var comments = [Comments]()
    @State var industries = [Category]()
    
    var body: some View {
        NavigationView {
            //3.
            VStack{
                List(comments) { comment in
                    VStack(alignment: .leading) {
                        Text("Name: " + "\(comment.name)")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("ID: " + "\(comment.id)")
                            .font(.subheadline)
                        Text("Password: " + "\(comment.password)")
                            .font(.subheadline)
                        Text("Sex: " + "\(comment.sex)")
                            .font(.subheadline)
                        Text("Age: " + "\(comment.age)")
                            .font(.subheadline)
                        Text("Graduation Year: " + "\(comment.graduation_year)")
                            .font(.subheadline)
                    }
                }
                //2.
                .onAppear() {
                    apiCall().getUserComments { (comments) in
                        self.comments = comments
                    }
                }
                
                List(industries){ industry in
                    VStack{
                        Text("Name: " + "\(industry.name)")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("ID: " + "\(industry.id)")
                    }
                }.onAppear() {
                    apiCall().getCategory { (industries) in
                        self.industries = industries
                    }
                }
            }.navigationTitle("User Table")
        }
    }
}

struct FirstView_Previews: PreviewProvider {
   static var previews: some View {
       FirstView()
   }
}
