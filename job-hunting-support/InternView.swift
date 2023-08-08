//
//  InternView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/05.
//
import SwiftUI

struct InternView: View {

    @State var InternshipList = [Internship_info]()
    
    @State var CompanyList = [Corporate_info]()
        
    @State var deleteAlert: Bool = false
        
    @State var response = ""
    
    @State private var deleteIndexSet: IndexSet?
    
    //ログインしているユーザーの情報
        @State var LoginUser: User = (LoadUserData() ?? User(name: "dummy", password: "01234", sex: "male", age: "20", graduate: "2023-03-31"))
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Section{
                        if InternshipList.count != 0 {
                            ForEach(InternshipList) { intern in
                                NavigationLink(destination:InternDetailView(interninfo: select(for: intern), companyList: CompanyList)){
                                    VStack(alignment: .leading){
                                        Text("開始日: \(intern.start)")
                                        Text("終了日: \(intern.end)")
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
                                            deleteSelectedInternInfo(at: indexSet)
                                            deleteIndexSet = nil
                                        }
                                    })
                                )
                            }
                        } else {
                            Text("インターン情報が登録されていません")
                        }
                    }
                }
            }
            .navigationTitle("インターン")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: InternAddView(userid: $LoginUser.id, internList: $InternshipList)) {
                        Text("追加")
                    }
                }
            }
            .onAppear(){
                print(LoginUser)
                apiCall().getInternshipInfoFromUserID(userID: LoginUser.id){ (internship_info) in
                    self.InternshipList = internship_info
                }
                print(InternshipList)
                apiCall().getCompanyInfoFromUserID(userID: LoginUser.id) { (corporate_info) in
                    self.CompanyList = corporate_info
                }
                print(CompanyList)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    //削除前のアラートを呼び出す
    private func deleteSelectedInternInfo(at indexSet: IndexSet) {
        for index in indexSet{
            let item = InternshipList[index]
            apiCall().deleteInternshipInfotoServer(id: item.id){ response in
                self.response = response
                if response == "OK" {
                    apiCall().getInternshipInfoFromUserID(userID: LoginUser.id) { (internship_info) in
                        self.InternshipList = internship_info
                    }
                }
            }
        }
    }
    
    private func select(for intern: Internship_info) -> Binding<Internship_info> {
        guard let internIndex = InternshipList.firstIndex(of: intern) else {
            fatalError("Infomation not found")
        }
        return $InternshipList[internIndex]
    }
}

struct InternView_Previews: PreviewProvider {
    static var previews: some View {
        InternView()
    }
}
