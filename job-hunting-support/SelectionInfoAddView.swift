//
//  SelectionInfoAddView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/05.
//

import SwiftUI

struct SelectionInfoAddView: View {
    
    //画面遷移
    @Environment(\.presentationMode) var presentationMode
    
    enum AlertType {
       case alert1
       case alert2
    }
    
    @State var alertType: AlertType = .alert1
    @State var showAlert = false
    @State var showbar = false
    
    //新規作成時の初期値
    @State private var companySelection = ""
    @State private var resultSelection = ""
    @State var newMemo = ""
    
    var userid: String
    @Binding var SelectionList: [Selection]
    @Binding var CompanyList: [Corporate_info]
    
    init(userid: String, selectionList: Binding<[Selection]>, companyList: Binding<[Corporate_info]>){
        self.userid = userid
        _SelectionList = selectionList
        _CompanyList = companyList
        let firstindex = Corporate_info(id: "0", user: "", name: "未選択", Industry: "", Occupation: "", business: "", establishment: "", employees: "", capital: "", sales: "", operating_income: "", representative: "", location: "", registration: "", memo: "")
        CompanyList.insert(firstindex, at: 0)
    }

    var body: some View {
        VStack{
            HStack{
                Text("企業情報")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Picker(selection: $companySelection, label: Text("企業情報")) {
                    ForEach(CompanyList) { Company in
                        Text("\(Company.name)").tag(Company.id)
                    }
                }
                .frame(width: 200)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
            }
            .frame(maxWidth: .infinity)
            .padding(.all, 20)

            HStack{
                Text("合否")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Picker(selection: $resultSelection, label: Text("合否")) {
                    Text("未選択").tag("0")
                    Text("合格").tag("pass")
                    Text("不合格").tag("fail")
                    Text("保留").tag("none")
                }
                .frame(width: 200)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
            }
            .frame(maxWidth: .infinity)
            .padding(.all, 20)
            
            HStack{
                VStack{
                    Text("メモ")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextEditor(text: $newMemo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                        .frame(width: 350, height: 200)
                }.padding()
            }
            .navigationTitle("選考情報の追加")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("作成") {
                if (((companySelection != "") && (companySelection != "0")) && ((resultSelection != "") && (resultSelection != "0"))) {
                    apiCall().addSelectionInfoToServer(userID: userid, corporate_info: companySelection, result: resultSelection, memo: newMemo) { response in
                        let response = response
                        if response == "OK"{
                            companySelection = ""
                            resultSelection = ""
                            newMemo = ""
                            
                            DispatchQueue.main.async {
                                presentationMode.wrappedValue.dismiss()
                            }
                        } else {
                            print("Error in Response")
                            alertType = .alert1
                            showAlert.toggle()
                        }
                    }
                } else {
                    print("Notfull")
                    alertType = .alert2
                    showAlert.toggle()
                }
            }.alert(isPresented: $showAlert) {
                switch alertType {
                    case .alert1:
                        return Alert(title: Text("エラーが発生しました。もう一度行ってください。"))
                    case .alert2:
                        return Alert(title: Text("すべての必須項目\n（企業名、開始日、終了日）\nを入力または選択してください。\nもし、企業名選択欄で、\n「未選択」のみであれば先に企業情報を追加してください"))
                }
            })
        }
    }
}

/*
 struct SelectionInfoAddView_Previews: PreviewProvider {
 static var previews: some View {
 SelectionInfoAddView()
 }
 }
 */
