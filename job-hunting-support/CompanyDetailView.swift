//
//  CompanyDetailsView.swift
//  job-hunting-support
//
//  Created by ibu.m ev on 2023/08/03.
//

import SwiftUI

//企業データの詳細表示
struct CompanyDetailView: View {
    //詳細表示する企業を保持する変数
    @Binding var company: Corporate_info
    @Binding var industryList : [Industry]
    @Binding var occupationList : [Occupation]
    
    //日付関連
    let dateFormatter = DateFormatter()
    
    //各パラメータの初期化
    init(company: Binding<Corporate_info>, industryList: Binding<[Industry]>, occupationList: Binding<[Occupation]>) {
        _company = company
        _industryList = industryList
        _occupationList = occupationList
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    //ナビゲーションバーの戻るボタンを消すための定義
    @Environment(\.presentationMode) var presentaion
    
    var body: some View {
        ScrollView{
            HStack{
                Text("業種")
                //.font(.title2)
                    .padding()
                if let viewindustry = industryList.first(where: {$0.id == company.industry}){
                    Text("\(viewindustry.name)")
                    //.font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                } else {
                    Text("未選択")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            HStack{
                Text("職種")
                //.font(.title2)
                    .padding()
                if let viewoccupation = occupationList.first(where: {$0.id == company.occupation}){
                    Text("\(viewoccupation.name)")
                    //.font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                } else {
                    Text("未選択")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            Group{
                VStack{
                    Text("事業内容")
                    //.font(.title2)
                        .padding()
                    Text(company.business)
                        .fixedSize(horizontal: false, vertical: true)
                    //.font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        ).padding()
                }
                HStack{
                    Text("設立日")
                    //.font(.title2)
                        .padding()
                    Text(company.establishment)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack{
                    Text("従業員数")
                    //.font(.title2)
                        .padding()
                    Text("\(company.employees)人")
                    //.font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack{
                    Text("資本金")
                    //.font(.title2)
                        .padding()
                    Text("\(company.capital)円")
                    //.font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack{
                    Text("売上高")
                    //.font(.title2)
                        .padding()
                    Text("\(company.sales)円")
                    //.font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack{
                    Text("営業利益")
                    //.font(.title2)
                        .padding()
                    Text("\(company.operating_income)円")
                    //.font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack{
                    Text("代表者")
                    //.font(.title2)
                        .padding()
                    Text(company.representative)
                    //.font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack{
                    Text("所在地")
                    //.font(.title2)
                        .padding()
                    Text(company.location)
                    //.font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack{
                    Text("メモ")
                    //.font(.title2)
                        .padding()
                    Text(company.memo)
                        .fixedSize(horizontal: false, vertical: true)
                    //.font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        ).padding()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("\(company.name)")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { presentaion.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.backward")
                }
            }
        }
        .navigationBarItems(trailing: {
            NavigationLink(destination: CompanyEditView(company: $company, industryList: $industryList, occupationList: $occupationList)) {
                Text("編集")
                //Image(systemName: "square.and.pencil")
            }
        }())
    }
}

/*
 
 struct CompanyDetailsView: View {
 //詳細表示する会社を保持する変数
 @Binding var company: corporate_info
 @Binding var industryList : [industry]
 @Binding var occupationList : [occupation]
 
 var body: some View {
 ScrollView{
 
 Text("従業員数: \(company.employees)").font(.title3)
 .padding()
 .frame(maxWidth: .infinity, alignment: .leading)
 
 Text("従業員数: \(company.employees)").font(.title3)
 .padding()
 .frame(maxWidth: .infinity, alignment: .leading)
 
 Text("従業員数: \(company.employees)").font(.title3)
 .padding()
 .frame(maxWidth: .infinity, alignment: .leading)
 
 Text("従業員数: \(company.employees)").font(.title3)
 .padding()
 .frame(maxWidth: .infinity, alignment: .leading)
 
 NavigationLink(destination: EditCompanyView(company: $company, industryList: $industryList, occupationList: $occupationList)) {
 Text("Edit")
 }
 }
 .navigationTitle("\(company.name)")
 }
 }
 */
