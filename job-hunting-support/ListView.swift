//
//  ListView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/06/22
//
//

import SwiftUI

struct ListView: View {
    //テスト動作用のユーザー、業種、職種
    var testUser = user(name: "dummy", password: "01234", sex: "male", age: "20", graduate: "2023-03-31")
    
    @State var testindustry = [
        industry(name:"未選択"),
        industry(name:"プログラマー"),
        industry(name: "WEBエンジニア"),
        industry(name: "インフラエンジニア")
    ]
    
    @State var testoccupation = [
        occupation(name:"未選択"),
        occupation(name: "正社員"),
        occupation(name:"契約社員"),
        occupation(name:"パート")
    ]
    
    //企業リスト
    @State var CompanyList = [corporate_info]()
    
    //削除のアラートの管理するフラグ
    @State var deleteAlert: Bool = false
    
    //削除する項目のindexを保持する変数
    @State private var deleteIndexSet: IndexSet?
    
    var body: some View {
        NavigationView {
            List {
                //企業のリスト表示
                ForEach(CompanyList) { company in
                    NavigationLink(destination: CompanyDetailsView(company: binding(for: company), industryList: $testindustry, occupationList: $testoccupation)) {
                        Text(company.name)
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
            }
            .navigationTitle("企業リスト")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddCompanyView(userid:testUser.id, companyList: $CompanyList, industryList: testindustry, occupationList: testoccupation)) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    //選択したCompanyの前処理
    private func binding(for company: corporate_info) -> Binding<corporate_info> {
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
        CompanyList.remove(atOffsets: indexSet)
    }
}
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
