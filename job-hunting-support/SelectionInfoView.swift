//
//  SelectionInfoView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/05.
//

import SwiftUI

struct SelectionInfoView: View {
    
    @State var SelectionList = [Selection]()
    
    @State var CompanyList = [Corporate_info]()
    
    //ログインしているユーザーの情報
    @State var LoginUser: User = (LoadUserData() ?? User(name: "dummy", password: "01234", sex: "male", age: "20", graduate: "2023-03-31"))
        
    @State var deleteAlert: Bool = false
        
    @State var response = ""
    
    @State private var deleteIndexSet: IndexSet?
    
    //カレンダー表示に関する変数
    @State var date = Date()
    private let dateFormatter = DateFormatter()
    init(){
        dateFormatter.dateFormat = "YYYY-MM-dd"
    }

    var body: some View {
        NavigationView{
            List{
                //ここに選考情報
                Section(/*header: Text("選考情報").font(.title3)*/){
                    if SelectionList.count != 0 {
                        ForEach(SelectionList) { selection in
                            NavigationLink(destination: SelectionInfoDetailView(companyList: CompanyList, selection: select(for: selection))){
                                if let viewcompany = CompanyList.first(where: {$0.id == selection.corporate_info}){
                                    Text("企業名: \(viewcompany.name)")
                                } else {
                                    Text("未選択")
                                }
                            }
                        }.onDelete { indexSet in
                            deleteIndexSet = indexSet
                            deleteAlert = true
                        }.alert(isPresented: $deleteAlert){
                            Alert(
                                title: Text("本当に削除しますか？"),
                                message: Text("削除すると、そのデータを復元することはできません"),
                                primaryButton: .cancel(),
                                secondaryButton: .destructive(Text("削除"), action: {
                                    if let indexSet = deleteIndexSet {
                                        deleteSelectedSelectionInfo(at: indexSet)
                                        deleteIndexSet = nil
                                    }
                                })
                            )
                        }
                    } else {
                        Text("本選考の情報が登録されていません")
                    }
                }
            }
            .navigationTitle("選考情報")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SelectionInfoAddView(userid: LoginUser.id, selectionList: $SelectionList, companyList: $CompanyList)) {
                        Text("追加")
                    }
                }
            }
            .onAppear(){
                apiCall().getCompanyInfoFromUserID(userID: LoginUser.id) { (corporate_info) in
                    self.CompanyList = corporate_info
                    let firstCompany = Corporate_info(id: "0", user: "", name: "未選択", Industry: "", Occupation: "", business: "", establishment: "", employees: "", capital: "", sales: "", operating_income: "", representative: "", location: "", registration: "", memo: "")
                    CompanyList.insert(firstCompany, at: 0)
                }
                
                //print(LoginUser)
                apiCall().getSelectionInfoFromUserID(userID: LoginUser.id){ (selection) in
                    self.SelectionList = selection
                }
                //print(SelectionList)
                
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func deleteSelectedSelectionInfo(at indexSet: IndexSet) {
        for index in indexSet{
            let item = SelectionList[index]
            apiCall().deleteSelectionInfoToServer(id: item.id){ response in
                self.response = response
                if response == "OK" {
                    apiCall().getSelectionInfoFromUserID(userID: LoginUser.id) { (selection) in
                        self.SelectionList = selection
                    }
                }
            }
        }
    }
    
    private func select(for selection: Selection) -> Binding<Selection> {
        guard let selectionIndex = SelectionList.firstIndex(of: selection) else {
            fatalError("Infomation not found")
        }
        return $SelectionList[selectionIndex]
    }
}

struct SelectionInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionInfoView()
    }
}
