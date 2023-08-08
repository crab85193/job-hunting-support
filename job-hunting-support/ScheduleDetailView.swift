//
//  ScheduleDetailView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/06.
//

import SwiftUI

struct ScheduleDetailView: View {
    
    @State var CategoryList = LoadCategoryData()
    
    @State var InternList : [Internship_info]
    @State var CompanyList : [Corporate_info]
    @Binding var ScheduleInfo: Schedule
    private let dateFormatter = DateFormatter()
    init(scheduleinfo: Binding<Schedule>, companylist: [Corporate_info], internlist: [Internship_info]){
        _ScheduleInfo = scheduleinfo
        CompanyList = companylist
        InternList = internlist
        print(CompanyList)
        print(InternList)
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "YYYY-MM-dd"
    }

    var body: some View {
            ScrollView{
                Text("スケジュール名")
                    .padding(.top, 30)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                VStack{
                    Text("\(ScheduleInfo.title)")
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.all, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
                .padding(.horizontal, 20)

                HStack{
                    Text("カテゴリー")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if let viewCategory = CategoryList.first(where: {$0.id == ScheduleInfo.schedule_category}){
                        Text(viewCategory.name)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    } else {
                        Text("未選択")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.all, 20)

                HStack{
                    Text("インターン情報")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if let viewintern = InternList.first(where: {$0.id == ScheduleInfo.internship_info}){
                        let viewCompanyid = viewintern.corporate_info
                        if let viewCompany = CompanyList.first(where: {$0.id == viewCompanyid}){
                            Text(viewCompany.name)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    } else {
                        Text("未選択")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.all, 20)

                HStack{
                    Text("企業情報")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if let viewCompany = CompanyList.first(where: {$0.id == ScheduleInfo.corporate_info}){
                        Text(viewCompany.name)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    } else {
                        Text("未選択")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.all, 20)

                HStack{
                    Text("スケジュール\n開始日")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if (ScheduleInfo.start != ""){
                        Text(ScheduleInfo.start)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    } else {
                        Text("記録なし")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .padding(.all, 20)

                HStack{
                    Text("スケジュール\n終了日")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if (ScheduleInfo.end != ""){
                        Text(ScheduleInfo.end)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    } else {
                        Text("記録なし")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .padding(.all, 20)

                HStack{
                    Text("メモ")
                        //.font(.title2)
                        .padding()
                    Text(ScheduleInfo.memo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
            }
            .navigationTitle("スケジュールの詳細")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ScheduleEditView(scheduleinfo: $ScheduleInfo, companylist: $CompanyList, internlist: $InternList)) {
                        Text("編集")
                    }
                }
            }
        
    }
}

/*
 struct ScheduleDetailView_Previews: PreviewProvider {
 static var previews: some View {
 ScheduleDetailView()
 }
 }
 */
