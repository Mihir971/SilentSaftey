//
//  ProfileFeilds.swift
//  SilentSafteyV3
//
//  Created by Mihir Thakur on 8/4/23.
//

import SwiftUI

struct ProfileFeilds: View {
    @AppStorage("name") private var name = ""
    @AppStorage("race") private var race = ""
    @AppStorage("gender") private var gender = ""
    @AppStorage("weight") private var weight = ""
    @AppStorage("year") private var year = ""
    @AppStorage("month") private var month = ""
    @AppStorage("day") private var day = ""
    @AppStorage("feet") private var feet = ""
    @AppStorage("inches") private var inches = ""
    @AppStorage("additional") private var additional = ""
    
    var body: some View {
        VStack {
            Form {
                Section("Name, Age, Race & Gender") {
                    TextField("Enter Name", text: $name)
                    TextField("Enter Race", text: $race)
                    TextField("Enter Gender", text: $gender)
                    TextField("Enter Year", text: $year)
                    TextField("Enter month", text: $month)
                    TextField("Enter day", text: $day)
                }
                Section("Height & Weight") {
                    TextField("Enter Weight", text: $weight)
                        .keyboardType(.numberPad)
                    TextField("Enter Height (Feet)", text: $feet)
                        .keyboardType(.numberPad)
                    TextField("Enter Height (Inches)", text: $inches)
                        .keyboardType(.numberPad)
                }
                Section("Aditional Information"){
                    TextEditor(text: $additional)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(height: UIScreen.screenWidth/2.5)
                }
            }
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem{
                Button {
                    print("saved")
                } label: {
                    Image(systemName: "person.fill.checkmark")
                        .foregroundColor(.green)
                }

            }
        }
    }
}

struct ProfileFeilds_Previews: PreviewProvider {
    static var previews: some View {
        ProfileFeilds()
    }
}
