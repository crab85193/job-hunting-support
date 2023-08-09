//
//  InternDetailView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/06.
//
import SwiftUI

struct InternDetailView: View {

    @State var CompanyList : [Corporate_info]
    @Binding var InternInfo : Internship_info
    private let dateFormatter = DateFormatter()
    init(interninfo : Binding<Internship_info>, companyList : [Corporate_info]){
        _InternInfo = interninfo
        CompanyList = companyList
        /*
        print("受け取った情報")
        print(InternInfo)
        print(CompanyList)
         */
    }

    var body: some View {
            VStack{
                HStack{
                    Text("企業名")
                        .font(.headline)
                        .padding()
                    if let viewCompany = CompanyList.first(where: {$0.id == InternInfo.corporate_info}){
                        Text("\(viewCompany.name)")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    } else {
                        Text("未選択")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }.overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))

                HStack{
                    Text("インターン\n開始日")
                        .font(.headline)
                        .padding()
                    if (InternInfo.start != ""){
                        Text(InternInfo.start)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    } else {
                        Text("記録なし")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }

                }.overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))

                HStack{
                    Text("インターン\n終了日")
                        .font(.headline)
                        .padding()
                    if (InternInfo.end != ""){
                        Text(InternInfo.end)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    } else {
                        Text("記録なし")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }

                }.overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))

                VStack{
                    Text("メモ")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    if (InternInfo.memo != "") {
                        Text(InternInfo.memo)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom)
                            .padding(.leading)
                            .padding(.trailing)
                    } else {
                        Text("記録なし")
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom)
                            .padding(.leading)
                            .padding(.trailing)
                    }

                }.overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
            }
            .navigationTitle("インターンの詳細")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: InternEditView(interninfo: $InternInfo, corporatelist: $CompanyList)) {
                        Text("編集")
                    }
                }
            }
        
    }
}

/*
 struct InternDetailView_Previews: PreviewProvider {
 static var previews: some View {
 InternDetailView()
 }
 }
 */
