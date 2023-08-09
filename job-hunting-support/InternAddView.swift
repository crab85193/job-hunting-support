//
//  InternAddView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/05.
//
import SwiftUI

struct InternAddView: View {

    //表示確認用
    @State var selectCompany = ""
    @State var newMemo = ""
    @State var StartDate = Date()
    @State var StartDateString = ""
    @State var FinishDate = Date()
    @State var FinishDateString = ""
    var userid: String
    @Binding var internList: [Internship_info]
    @State var CompanyList = [Corporate_info]()
    
    private let dateFormatter = DateFormatter()
    init(userid: String, internList: Binding<[Internship_info]>){
        self.userid = userid
        _internList = internList
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "YYYY-MM-dd"
    }
    
    //画面遷移
    @Environment(\.presentationMode) var presentationMode
    
    enum AlertType {
       case alert1
       case alert2
    }
    
    @State var alertType: AlertType = .alert1
    @State var showAlert = false
    @State var showbar = false

    var body: some View {
        ScrollView{
            VStack{
                VStack{
                    HStack{
                        Text("企業名")
                            .padding()
                            .frame(width: 100)
                        Section{
                            Picker(selection: $selectCompany, content: {
                                ForEach(CompanyList) { Company in
                                    Text("\(Company.name)").tag(Company.id)
                                }
                            }, label: { Text("企業名") }).pickerStyle(MenuPickerStyle())
                        }
                        .autocapitalization(.none)
                        .frame(width: 250, height:50)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                        .padding()
                        Spacer()
                    }
                    
                    HStack{
                        Text("インターン開始日")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        DatePicker("Calendar", selection: $StartDate, displayedComponents: .date).environment(\.locale, Locale(identifier: "ja_JP"))
                            .labelsHidden()
                    }.padding()
                    
                    HStack{
                        Text("インターン終了日")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        DatePicker("Calendar", selection: $FinishDate, displayedComponents: .date).environment(\.locale, Locale(identifier: "ja_JP"))
                            .labelsHidden()
                    }.padding()

                    VStack{
                        Text("メモ")
                            .frame(width: 340, alignment: .leading)
                        TextEditor(text:$newMemo)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                            .frame(width: 350, height: 200)
                    }.padding()
                }
                .padding()
                /*
                HStack{
                    Text("メモ")
                        //.font(.title2)
                        .padding()
                    TextField("メモ", text:$newMemo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
                 */
                
            }
            .navigationTitle("インターン情報を追加")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("追加") {
                StartDateString = dateFormatter.string(from: StartDate)
                //print("変更後")
                //print(StartDateString)
                FinishDateString = dateFormatter.string(from: FinishDate)
                //print("変更後")
                //print(FinishDateString)
                //print(selectCompany)
                //print(newMemo)
                if ((selectCompany != "") && (selectCompany != "0")) {
                    apiCall().addInternshipInfoToServer(userID: userid, corporate_info: selectCompany, start_date: StartDateString, end_date: FinishDateString, memo: newMemo) { response in
                        let response = response
                        if response == "OK" {
                            StartDate = Date()
                            FinishDate = Date()
                            newMemo = ""
                            
                            DispatchQueue.main.async {
                                presentationMode.wrappedValue.dismiss()
                            }
                        } else {
                           //print("Error in Response")
                            alertType = .alert1
                            showAlert.toggle()
                        }
                    }
                } else {
                    //print("Notfull")
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
 struct InternAddView_Previews: PreviewProvider {
 static var previews: some View {
 InternAddView()
 }
 }
 */
