//
//  ScheduleAddView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/05.
//

import SwiftUI

struct ScheduleAddView: View {

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
    @State private var scheduleName = ""
    @State private var categorySelection = ""
    @State private var internSelection = ""
    @State private var companySelection = "1"
    @State var scheduleStartDate = Date()
    @State var scheduleFinishDate = Date()
    @State var newMemo = ""
    
    @State var CategoryList = LoadCategoryData()
    
    var userid: String
    @Binding var scheduleList: [Schedule]
    @Binding var CompanyList: [Corporate_info]
    @Binding var InternList: [Internship_info]
    
    private let dateFormatter = DateFormatter()
    init(userid: String, schedulelist: Binding<[Schedule]>, companylist: Binding<[Corporate_info]>, internlist: Binding<[Internship_info]>){
        self.userid = userid
        _scheduleList = schedulelist
        _CompanyList = companylist
        _InternList = internlist
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "YYYY-MM-dd"
    }

    var body: some View {
        VStack{
            ScrollView{
                VStack {
                    Text("スケジュール名")
                        .padding(.top, 30)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    TextField("スケジュール名", text:$scheduleName)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 20)
                        .autocapitalization(.none)
                }
                
                HStack{
                    Text("カテゴリー")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Picker(selection: $categorySelection, content: {
                        ForEach(CategoryList) { category in
                            Text("\(category.name)").tag(category.id)
                        }
                    }, label: { Text("カテゴリー") })
                    .frame(width: 200)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                }
                .frame(maxWidth: .infinity)
                .padding(.all, 20)

                HStack{
                    Text("インターン情報")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Picker(selection: $internSelection, content: {
                        ForEach(InternList) { intern in
                            if let viewCompany = CompanyList.first(where: {$0.id == intern.corporate_info}) {
                                Text("\(viewCompany.name)").tag(intern.id)
                            }
                            
                        }
                    }, label: { Text("インターン情報") })
                    .frame(width: 200)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                }
                .frame(maxWidth: .infinity)
                .padding(.all, 20)

                HStack{
                    Text("企業情報")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Picker(selection: $companySelection, content: {
                        ForEach(CompanyList) { company in
                            Text("\(company.name)").tag(company.id)
                        }
                    }, label: { Text("企業情報") })
                    .frame(width: 200)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                }
                .frame(maxWidth: .infinity)
                .padding(.all, 20)

                HStack{
                    Text("スケジュール開始日")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    DatePicker("Calendar", selection: $scheduleStartDate, displayedComponents: .date).environment(\.locale, Locale(identifier: "ja_JP"))
                        .labelsHidden()
                }
                .padding(.all, 20)

                HStack{
                    Text("スケジュール終了日")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    DatePicker("Calendar", selection: $scheduleFinishDate, displayedComponents: .date).environment(\.locale, Locale(identifier: "ja_JP"))
                        .labelsHidden()
                }
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
            }
            .navigationTitle("スケジュールを追加")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("作成") {
                if ((scheduleName != "") && ((categorySelection != "") && (categorySelection != "0")) && ((companySelection != "") && (companySelection != "0")) && ((internSelection != "") && (internSelection != "0"))) {
                    let StartDateString = dateFormatter.string(from: scheduleStartDate)
                    let EndDateString = dateFormatter.string(from: scheduleFinishDate)
                    apiCall().addScheduleInfoToServer(title: scheduleName, userID: userid, schedule_category: categorySelection, internship_info: internSelection, corporate_info: companySelection, start_date: StartDateString, end_date: EndDateString, memo: newMemo) { response in
                        let response = response
                        if response == "OK"{
                            scheduleStartDate = Date()
                            scheduleFinishDate = Date()
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
                        return Alert(title: Text("すべての必須項目\n（スケジュール名、カテゴリー、企業情報、インターン情報）\nを入力または選択してください。\nもし、企業名またはインターン情報選択欄で、\n「未選択」のみであれば先に企業情報を追加してください"))
                }
            })
        }
    }
}

/*
 struct ScheduleAddView_Previews: PreviewProvider {
 static var previews: some View {
 ScheduleAddView()
 }
 }
 */
