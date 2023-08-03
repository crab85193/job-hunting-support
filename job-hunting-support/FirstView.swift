//
//  FirstView.swift
//  job-hunting-support
//  
//  Created by 宮平保 on 2023/06/22
//  
//

import SwiftUI

struct FirstView: View {
    
    @State var comments = [Comments]()
    
    var body: some View {
        NavigationView {
            //3.
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
            }.navigationTitle("User Table")
        }
    }
}

struct FirstView_Previews: PreviewProvider {
   static var previews: some View {
       FirstView()
   }
}
