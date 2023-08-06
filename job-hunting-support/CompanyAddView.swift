//
//  AddCompanyView.swift
//  job-hunting-support
//
//  Created by ibu.m ev on 2023/08/03.
//

import SwiftUI

//新規企業データの作成
struct CompanyAddView: View {
    
    //画面遷移
    @Environment(\.presentationMode) var presentationMode
    
    var userid: String //ユーザーID
    @Binding var companyList: [Corporate_info] //企業リスト
    var industryList: [Industry] //職種リスト
    var occupationList: [Occupation] //業種リスト
    
    //日付関連
    let dateFormatter = DateFormatter()
    
    //各種パラメータの初期化
    init(userid: String,companyList: Binding<[Corporate_info]>, industryList: [Industry], occupationList: [Occupation]) {
        self.userid = userid
        self.industryList = industryList
        self.occupationList = occupationList
        _companyList = companyList
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    enum AlertType {
       case alert1
       case alert2
    }
    
    @State private var response = ""
    @State var alertType: AlertType = .alert1
    @State var showAlert = false
    
    //新規作成時の初期値
    @State private var newName = ""
    @State private var selectindustry: String = ""
    @State private var selectoccupation: String = ""
    @State private var newbusiness = ""
    @State private var selectionDate = Date()
    @State private var selectionDateString = ""
    @State private var newEmployees = 0
    @State private var newcapital = 0
    @State private var newsales = 0
    @State private var newincome = 0
    @State private var newrepresentative = ""
    @State private var newlocation = ""
    @State private var newmemo = ""
    @State private var currentdate = Date()
    
    //キーボードの利用検知
    @FocusState  var isActive:Bool
    
    //ナビゲーションバーの戻るボタンを消すための定義
    @Environment(\.presentationMode) var presentaion
    
    //ScrollViewで指定した場所まで飛ぶための変数定義
    @State private var indexnum = 0
    
    var body: some View {
        ScrollViewReader{reader in
            ScrollView{
                /*
                //最初にカテゴリーから検索するのか新規作成するのか選択する部分
                Group{
                    Text("追加方法を選択")
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                        .padding(.top, 20)
                    HStack{
                        Button(action: {
                            //ここにボタンを押したときの動作を記述
                            indexnum = 1
                            withAnimation (.easeInOut){
                                reader.scrollTo(indexnum, anchor: .top)
                            }
                        }){
                        Text("カテゴリー\nから検索")
                             .foregroundColor(Color.white)
                             .frame(width: 130, height: 60, alignment: .center)
                             .background(Color.green)
                             .cornerRadius(50)
                            /*
                            // 文字色をブルーに指定
                            .foregroundColor(.blue)
                            // フレームのサイズを指定
                            .frame(width: 130, height: 60, alignment: .center)
                            // 枠線で囲って文字を重ねる
                            .overlay(RoundedRectangle(cornerRadius: 20)
                            // 枠線の色をブルーに指定
                            .stroke(Color.blue, lineWidth: 2)
                            )
                             */
                        }
                        Button(action: {
                            //ここにボタンを押したときの動作を記述
                            indexnum = 2
                            withAnimation (.easeInOut){
                                reader.scrollTo(indexnum, anchor: .top)
                            }
                        }){
                        Text("新規作成")
                            .foregroundColor(Color.white)
                            .frame(width: 130, height: 60, alignment: .center)
                            .background(Color.pink)
                            .cornerRadius(50)
                        }
                    }
                }
                
                Rectangle()
                    .foregroundColor(.black)
                    .frame(width: .infinity, height: 0.5)
                    .padding(.vertical, 30)
                
                //カテゴリーから選択する部分
                Group{
                    Text("カテゴリーから選択").id(1)
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                    VStack{
                        HStack{
                            Text("業種")
                                //.font(.title2)
                                .padding()
                            Section{
                                Picker(selection: $selectindustry, content: {
                                    ForEach(industryList) { industry in
                                        Text("\(industry.name)").tag(industry.id)
                                    }
                                }, label: { Text("業種") }).pickerStyle(MenuPickerStyle())
                            }.autocapitalization(.none)
                        }
                        HStack{
                            Text("職種")
                                //.font(.title2)
                                .padding()
                            Section{
                                Picker(selection: $selectoccupation, content: {
                                    ForEach(occupationList) { occupation in
                                        Text("\(occupation.name)").tag(occupation.id)
                                    }
                                }, label: { Text("職種") }).pickerStyle(MenuPickerStyle())
                            }.autocapitalization(.none)
                        }
                        Button(action: {
                            //ここにボタンを押したときの動作を記述
                        }){
                            HStack{
                                Text("検索")
                                Image(systemName: "magnifyingglass")
                            }
                            .foregroundColor(Color.white)
                            .frame(width: 130, height: 50, alignment: .center)
                            .background(Color.blue)
                            .cornerRadius(50)
                        }
                    }
                }
                
                Rectangle()
                    .foregroundColor(.black)
                    .frame(width: .infinity, height: 0.5)
                    .padding(.vertical, 30)
                */
                 
                //新規作成の部分
                Text("新規作成").id(2)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)
                
                HStack{
                    Text("企業名")
                        .padding()
                        .frame(width: 100)
                    TextField("株式会社タカアシガニ", text:$newName)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(width: 280)
                        .autocapitalization(.none)
                    Spacer()
                }
                
                HStack{
                    Text("業種")
                        .padding()
                        .frame(width: 100)
                    Section{
                        Picker(selection: $selectindustry, content: {
                            ForEach(industryList) { industry in
                                Text("\(industry.name)").tag(industry.id)
                            }
                        }, label: { Text("業種") }).pickerStyle(MenuPickerStyle())
                    }
                    .autocapitalization(.none)
                    .frame(width: 250, height:50)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                    .padding()
                    Spacer()
                }
                
                HStack{
                    Text("職種")
                        .padding()
                        .frame(width: 100)
                    Section{
                        Picker(selection: $selectoccupation, content: {
                            ForEach(occupationList) { occupation in
                                Text("\(occupation.name)").tag(occupation.id)
                            }
                        }, label: { Text("職種") }).pickerStyle(MenuPickerStyle())
                    }
                    .autocapitalization(.none)
                    .frame(width: 250, height:50)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                    .padding()
                    Spacer()
                }
                Group{
                    HStack{
                        VStack{
                            Text("事業内容")
                                .frame(width: 350, alignment: .leading)
                            TextEditor(text: $newbusiness)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                                .frame(width: 350, height: 200)
                        }.padding()
                    }
                    HStack{
                        DatePicker("設立日", selection: $selectionDate, displayedComponents: .date).environment(\.locale, Locale(identifier: "ja_JP"))
                            .padding()
                            .frame(width: 380)
                    }
                    HStack{
                        Text("従業員数")
                            .padding()
                            .frame(width: 100)
                        TextField("従業員数", value:$newEmployees, format: .number)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                            .keyboardType(.numberPad)
                            .focused($isActive)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .frame(width: 280)
                            .autocapitalization(.none)
                    }
                    HStack{
                        Text("資本金")
                            .padding()
                            .frame(width: 100)
                        TextField("資本金", value:$newcapital, format: .number)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                            .keyboardType(.numberPad)
                            .focused($isActive)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .frame(width: 280)
                            .autocapitalization(.none)
                    }
                    HStack{
                        Text("売上高")
                            .padding()
                            .frame(width: 100)
                        TextField("売上高", value:$newsales, format: .number)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                            .keyboardType(.numberPad)
                            .focused($isActive)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .frame(width: 280)
                            .autocapitalization(.none)
                    }
                    HStack{
                        Text("営業利益")
                            .padding()
                            .frame(width: 100)
                        TextField("営業利益", value:$newincome, format: .number)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                            .keyboardType(.numberPad)
                            .focused($isActive)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .frame(width: 280)
                            .autocapitalization(.none)
                    }
                    HStack{
                        Text("代表者")
                            .padding()
                            .frame(width: 100)
                        TextField("山田 太郎", text:$newrepresentative)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .frame(width: 280)
                            .autocapitalization(.none)
                    }
                    HStack{
                        VStack{
                            Text("所在地")
                                .frame(width: 340, alignment: .leading)
                            TextField("沖縄県中頭郡西原町字千原1番地", text:$newlocation)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 350)
                                .autocapitalization(.none)
                        }.padding()
                    }
                    HStack{
                        VStack{
                            Text("メモ")
                                .frame(width: 340, alignment: .leading)
                            TextEditor(text: $newmemo)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                                .frame(width: 350, height: 200)
                        }.padding()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("企業リスト 追加")
        .navigationBarItems(trailing: Button("作成") {
            print("変更前")
            print(selectionDate)
            selectionDateString = dateFormatter.string(from: selectionDate)
            print("変更後")
            print(selectionDateString)
            if ((newName != "") && ((selectindustry != "") && (selectindustry != "0")) && ((selectoccupation != "") && (selectoccupation != "0")) && (newlocation != "")){
                apiCall().addCompanyInfotoServer(userID: userid, name: newName, industry: selectindustry, occupation: selectoccupation, business: newbusiness, establishment: selectionDateString, employees: String(newEmployees), capital: String(newcapital), sales: String(newsales), operating_income: String(newincome), representative: newrepresentative, location: newlocation, registration: dateFormatter.string(from: currentdate), memo: newmemo) { response in
                    self.response = response
                    if response == "OK"{
                        //企業データ入力部分の初期化
                        newName = ""
                        newbusiness = ""
                        selectionDate = Date()
                        newEmployees = 0
                        newcapital = 0
                        newsales = 0
                        newincome = 0
                        newrepresentative = ""
                        newlocation = ""
                        newmemo = ""
                        currentdate = Date()
                        
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
                    return Alert(title: Text("すべての必須項目\n（企業名、職種、業種、住所）\nを入力または選択してください。"))
            }
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                  Button(action: { presentaion.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.backward")
                }
            }
            //キーボードを閉じるボタン
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()         // 右寄せにする
                Button("閉じる") {
                    isActive = false  //  フォーカスを外す
                }
            }
        }
        Spacer()
    }
}
