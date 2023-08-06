//
//  ListView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/06/22
//
//

import SwiftUI

struct CompanyListView: View {
    //テスト動作用のユーザー、業種、職種
    var testUser = User(name: "dummy", password: "01234", sex: "male", age: "20", graduate: "2023-03-31")
    
    @State var testindustry = [
        Industry(name:"未選択"),
        Industry(name:"プログラマー"),
        Industry(name: "WEBエンジニア"),
        Industry(name: "インフラエンジニア")
    ]
    
    @State var testoccupation = [
        Occupation(name:"未選択"),
        Occupation(name: "正社員"),
        Occupation(name:"契約社員"),
        Occupation(name:"パート")
    ]
    //ログインしているユーザーの情報
        @State var LoginUser: User = (LoadUserData() ?? User(name: "dummy", password: "01234", sex: "male", age: "20", graduate: "2023-03-31"))
    
    //企業リスト
    @State var CompanyList = [Corporate_info]()
    
    @State var IndustryList = LoadIndustryData()
    
    @State var OccupationList = LoadOccupationData()
    
    //削除のアラートの管理するフラグ
    @State var deleteAlert: Bool = false
    
    @State var response = ""
    
    //削除する項目のindexを保持する変数
    @State private var deleteIndexSet: IndexSet?
    
    var body: some View {
        NavigationView {
            List {
                Section(/*header: Text("企業リスト").font(.title3)*/){
                    if CompanyList.count != 0 {
                        //企業のリスト表示
                        ForEach(CompanyList) { company in
                            NavigationLink(destination: CompanyDetailView(company: binding(for: company), industryList: $IndustryList, occupationList: $OccupationList)) {
                                VStack(alignment: .leading){
                                    Text(company.name)
                                        .fontWeight(.bold)
                                    if let viewindustry = IndustryList.first(where: {$0.id == company.industry}){
                                        Text("\(viewindustry.name)")
                                    } else {
                                        Text("未選択")
                                    }
                                    if let viewoccupation = OccupationList.first(where: {$0.id == company.occupation}){
                                        Text("\(viewoccupation.name)")
                                    } else {
                                        Text("未選択")
                                    }
                                }
                            }
                        }
                        //削除ボタン
                        .onDelete { indexSet in
                            deleteIndexSet = indexSet
                            deleteAlert = true
                        }
                        //削除前のアラート
                        .alert(isPresented: $deleteAlert) {
                            Alert(
                                title: Text("本当に削除しますか？"),
                                message: Text("削除すると、そのデータを復元することはできません"),
                                primaryButton: .cancel(),
                                secondaryButton: .destructive(Text("削除"), action: {
                                    if let indexSet = deleteIndexSet {
                                        deleteSelectedCompanies(at: indexSet)
                                        deleteIndexSet = nil
                                    }
                                })
                            )
                        }
                    }else {
                        Text("会社が登録されていません。")
                    }
                }
            }
            .navigationTitle("企業リスト")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CompanyAddView(userid:LoginUser.id, companyList: $CompanyList, industryList: IndustryList, occupationList: OccupationList)) {
                        Text("追加")
                    }
                }
            }
            .onAppear(){
                print(LoginUser)
                apiCall().getCompanyInfoFromUserID(userID: LoginUser.id) { (corporate_info) in
                    self.CompanyList = corporate_info
                }
                print(CompanyList)
            }
        }
    }
    
    //選択したCompanyの前処理
    private func binding(for company: Corporate_info) -> Binding<Corporate_info> {
        guard let companyIndex = CompanyList.firstIndex(of: company) else {
            fatalError("Person not found")
        }
        return $CompanyList[companyIndex]
    }
    
    //削除前のアラートを呼び出す
    private func deletecompany(at offsets: IndexSet) {
        deleteAlert = true
    }
    
    //項目の削除を行う
    private func deleteSelectedCompanies(at indexSet: IndexSet) {
        for index in indexSet{
            let item = CompanyList[index]
            apiCall().deleteCompanyInfotoServer(id: item.id){ response in
                self.response = response
                if response == "OK" {
                    apiCall().getCompanyInfoFromUserID(userID: LoginUser.id) { (corporate_info) in
                        self.CompanyList = corporate_info
                    }
                }
            }
        }
        CompanyList.remove(atOffsets: indexSet)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyListView()
    }
}
