//
//  SearchForm.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/5.
//

import SwiftUI
import Alamofire
import PopoverSwiftUI

struct SearchForm: View {
    
    @EnvironmentObject var businessViewModel: BusinessViewModel
    
    @State var keyword: String = ""
    @State var distance: String = "10"
    @State var selectedCategory = SearchCategory.Default
    @State var isAutoDectct:Bool = false
    @State var location:String = ""
    @State var latitude:String = ""
    @State var longitude:String = ""
    
    //autocomplete
    @State var isShowingAutoCompletePopover = false
    @State var autoCompleteTextArray = [String]()
    
    // validate
    @State var isShowingInvalidToast = false

    var body: some View {
        VStack{
            HStack {
                Text("Keyword:")
                    .foregroundColor(.secondary)
                TextField("Required",text:$keyword)
                    .onChange(of: keyword){ keyworValue in
                            autoCompleteTextArray = [String]()
                    }
                    .onSubmit {
                            Task{
                                autoCompleteTextArray = try await AutoCompleteViewModel().AutoCompleteText(keyword: keyword)
                            }
                            self.isShowingAutoCompletePopover = true
                    }
                    .alwaysPopover(isPresented: $isShowingAutoCompletePopover){
                        if autoCompleteTextArray.count > 0 {
                            VStack{
                                ForEach(autoCompleteTextArray, id:\.self){ autoCompleteText in
                                    Button(action: {
                                        keyword = autoCompleteText
                                        isShowingAutoCompletePopover = false //strange but work
                                    }) {
                                        Text("\(autoCompleteText)")
                                            .foregroundColor(Color.secondary)
                                    }
                                }
                                .padding(.leading)
                                .padding(.trailing)
                            }
                            .padding(.top)
                            .padding(.bottom)
                        } else {
                                HStack{
                                    Spacer()
                                    ProgressView("loading")
                                    Spacer()
                                }
                                .padding()
                        }
  
                    }
            }
            HStack {
                Text("Distance:")
                    .foregroundColor(.secondary)
                TextField("",text:$distance)
            }
            HStack {
                Text("Category:")
                    .foregroundColor(.secondary)
                Picker("", selection: $selectedCategory) {
                    ForEach(SearchCategory.allCases){ category in
                        Text(category.rawValue)
                    }
                }
                .pickerStyle(.menu)
                Spacer()
            }
            if !isAutoDectct {
                HStack {
                    Text("Location:")
                        .foregroundColor(.secondary)
                    TextField("Required",text:$location)
                }
            }
            Toggle(isOn: $isAutoDectct){
                Text("Auto-detect my location")
                    .foregroundColor(.secondary)
            }
            .onChange(of: isAutoDectct){ isAutoDectctValue in
                Task{
                    location = ""
                    if isAutoDectctValue {
                        let coordinatesTurple = try await IpInfoViewModel().AutoGetLocation()
                        latitude = coordinatesTurple.latitude
                        longitude = coordinatesTurple.longitude
                    }
                }
            }
            HStack{
                if keyword != "" && distance != "" && (location != "" || (latitude != "" && longitude != "")) {
                    Button(action: {
                        businessViewModel.isSubmitButtonClicked = true
                        if location == "" && latitude != "" && longitude != "" {
                            Task{
                                try await                             businessViewModel.SearchBusinesses(keyword: keyword, latitude: latitude, longitude: longitude, distance: distance, category: selectedCategory.rawValue)
                                businessViewModel.isBusinessSearched = true
                            }
                        }
                        if location != "" {
                            Task{
                                let coordinatesTurple = try await GeoCodeViewModel().GoogleGetLocation(location: location)
                                if coordinatesTurple.latitude != "0" && coordinatesTurple.longitude != "0" {
                                    let newlatitude = coordinatesTurple.latitude
                                    let newlongitude = coordinatesTurple.longitude
                                    try await businessViewModel.SearchBusinesses(keyword: keyword, latitude: newlatitude, longitude: newlongitude, distance: distance, category: selectedCategory.rawValue)
                                    businessViewModel.isBusinessSearched = true
                                } else {
                                    businessViewModel.isBusinessSearched = true
                                }
                            }
                        }

                    }) {
                        Text("Submit")
                            .frame(width: 120, height:45)
                            .foregroundColor(Color.white)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 1, green: 0.2313, blue: 0.1882)))
                    }
                } else {
                    Button(action: {
                        if keyword == "" || (location == "" && !isAutoDectct) {
                            isShowingInvalidToast = true
                        }
                    }) {
                        Text("Submit")
                            .frame(width: 120, height:45)
                            .foregroundColor(Color.white)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color(hue: 3, saturation: 0, brightness: 0.67)))
                    }
                }
                Spacer()
                Button(action: {
                    keyword = ""
                    distance = "10"
                    selectedCategory = SearchCategory.Default
                    isAutoDectct = false
                    location = ""
                    latitude = ""
                    longitude = ""
                    isShowingAutoCompletePopover = false
                    autoCompleteTextArray = [String]()
                    businessViewModel.businessesData = [Business]()
                    businessViewModel.isBusinessSearched = false
                    businessViewModel.isSubmitButtonClicked = false
                }) {
                    Text("Clear")
                        .frame(width: 120, height:45)
                        .foregroundColor(Color.white)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue))
                }
            }
            .padding(.top)
            .padding(.leading)
            .padding(.trailing)
            .buttonStyle(PlainButtonStyle())
            
            //Text("")
            //Text("")
            HStack{}
                .frame(maxWidth: .infinity, alignment: .center)
                .toast(isPresented: $isShowingInvalidToast){
                    HStack{
                        if keyword == "" {
                            Text("Please enter a keyword.")
                                .foregroundColor(Color(red: 0.3647, green: 0.3647, blue: 0.3647))
                                .padding()
                        } else if (location == "" && !isAutoDectct) {
                            Text("Please enter a location.")
                                .foregroundColor(Color(red: 0.3647, green: 0.3647, blue: 0.3647))
                                .padding()
                        }
                    }
                }
            Text("")
            Text("")
        }
    }   
}

struct SearchForm_Previews: PreviewProvider {
    static var previews: some View {
        SearchForm()
    }
}
