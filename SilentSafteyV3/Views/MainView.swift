//
//  MainView.swift
//  SilentSafteyV3
//
//  Created by Mihir Thakur on 8/4/23.
//

import SwiftUI

struct MainView: View {
    @State var messageToSend = ""
    @State var oneIsClicked = false
    @State var CustomPhoneNumberToCall = ""
    let phoneBot = PhoneCall()
    let locMan = LocationManager()
    
    var body: some View {
        NavigationView{
            VStack{
                Group{
                    HStack{
                        PoliceButton(oneIsClicked: $oneIsClicked, PhoneBot: phoneBot, locMan: locMan)
                        FireButton(oneIsClicked: $oneIsClicked, PhoneBot: phoneBot)
                    }
                    .padding(.top, 20)
                    HStack{
                        HealthButton(oneIsClicked: $oneIsClicked, PhoneBot: phoneBot)
                        CustomButton(oneIsClicked: $oneIsClicked, PhoneBot: phoneBot)
                    }
                }//Emergency Buttons
                Spacer()
                HStack{
                    TextField("message to operator", text: $messageToSend)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button {
                        sendAdditionalMessageNotification(additionalMessage: messageToSend)
                        messageToSend = ""
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .padding(.trailing)
                            .foregroundColor(.gray)
                    }
                }//textfeild & button
            }
            .navigationTitle("SilentSaftey")
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        ProfileFeilds()
                    } label: {
                        Image(systemName: "person.fill")
                            .foregroundColor(.gray)
                    }
                }//profile button
                ToolbarItem {
                    NavigationLink {
                        ToAbout()
                    } label: {
                        Image(systemName: "magazine.fill")
                            .foregroundColor(.gray)
                    }
                }//toutorial button
            }
        }.tint(.white)
    }
    
    func sendAdditionalMessageNotification(additionalMessage: String) {
        NotificationCenter.default.post(name: Notification.Name("MyNotification"), object: nil, userInfo: ["key": "\(additionalMessage)"])
    }
    
    func getLocationString() -> String{
        var locationString = ""
        locMan.fetchUserLocation { streetAddress, location in
            if let streetAddress = streetAddress {
                locationString.append("the street adress of the user is \(streetAddress)")
            } else {
                print("Failed to get street address.")
            }
            if let location = location {
                locationString.append(" and the lattitude and longitude coordinates of the user is lattidtude \(location.coordinate.latitude) and longitude of \(location.coordinate.longitude)")
            } else {
                print("Failed to get latitude and longitude.")
            }
        }
        return locationString
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//MARK: - UIButtons

struct PoliceButton: View{
    @State var Clicked = false
    @Binding var oneIsClicked: Bool
    @State var PhoneBot: PhoneCall // Add this line to access the PhoneCall instance
    let locMan: LocationManager
    
    var body: some View{
        Button {
            Clicked.toggle()
            oneIsClicked.toggle()
            if Clicked {
                PhoneBot.makeCall(withPhoneNumber: "+19714001345") // test number
                Clicked.toggle()
                oneIsClicked.toggle()
            }
        } label: {
            Text("🚓")
                .font(.largeTitle)
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: (UIScreen.screenWidth - 20)/2.25, height: (UIScreen.screenWidth - 20)/2.25)
                        .foregroundColor(.red.opacity(0.5))
                        .shadow(color: Clicked == true ? .red : .clear, radius: 10)
                }
                .frame(width: (UIScreen.screenWidth - 20)/2.25, height: (UIScreen.screenWidth - 20)/2.25)
        }
        .disabled(oneIsClicked && !Clicked)
    }
}

struct FireButton: View{
    @State var Clicked = false
    @Binding var oneIsClicked: Bool
    @State var PhoneBot: PhoneCall
    
    var body: some View{
        Button {
            print("fire")
            Clicked.toggle()
            oneIsClicked.toggle()
            if Clicked {
                PhoneBot.makeCall(withPhoneNumber: "911") // Replace "911" with the actual emergency number for your region
            }
        } label: {
            Text("🚒")
                .font(.largeTitle)
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: (UIScreen.screenWidth - 20)/2.25, height: (UIScreen.screenWidth - 20)/2.25)
                        .foregroundColor(.red.opacity(0.5))
                        .shadow(color: Clicked == true ? .red : .clear, radius: 10)
                }
                .frame(width: (UIScreen.screenWidth - 20)/2.25, height: (UIScreen.screenWidth - 20)/2.25)
        }
        .disabled(oneIsClicked && !Clicked)
    }
}

struct HealthButton: View{
    @State var Clicked = false
    @Binding var oneIsClicked: Bool
    let PhoneBot: PhoneCall

    var body: some View{
        Button {
            print("ambulance")
            Clicked.toggle()
            oneIsClicked.toggle()
            if Clicked {
//                PhoneBot.makeCall(withPhoneNumber: "911") // Replace "911" with the actual emergency number for your region
            }
        } label: {
            Text("🚑")
                .font(.largeTitle)
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: (UIScreen.screenWidth - 20)/2.25, height: (UIScreen.screenWidth - 20)/2.25)
                        .foregroundColor(.red.opacity(0.5))
                        .shadow(color: Clicked == true ? .red : .clear, radius: 10)
                }
                .frame(width: (UIScreen.screenWidth - 20)/2.25, height: (UIScreen.screenWidth - 20)/2.25)
        }
        .disabled(oneIsClicked && !Clicked)
    }
}

struct CustomButton: View{
    @State var Clicked = false
    @Binding var oneIsClicked: Bool
    let PhoneBot: PhoneCall

    var body: some View{
        Button {
            print("custom")
            Clicked.toggle()
            oneIsClicked.toggle()
            if Clicked {
                PhoneBot.makeCall(withPhoneNumber: "911") // Replace "911" with the actual emergency number for your region
            }
        } label: {
            Text("☎️")
                .font(.largeTitle)
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: (UIScreen.screenWidth - 20)/2.25, height: (UIScreen.screenWidth - 20)/2.25)
                        .foregroundColor(.red.opacity(0.5))
                        .shadow(color: Clicked == true ? .red : .clear, radius: 10)
                }
                .frame(width: (UIScreen.screenWidth - 20)/2.25, height: (UIScreen.screenWidth - 20)/2.25)
        }
        .disabled(oneIsClicked && !Clicked)
    }
}

//MARK: - Toutorial Navigation Links

struct ToAbout: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        VStack{
            TabView(selection: $selectedIndex) {
                AboutPhone()
                    .tag(0)
                AboutLocation()
                    .tag(1)
                AboutButton()
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .gesture(DragGesture().onEnded { gesture in
                if gesture.translation.width > 0 {
                    selectedIndex = max(selectedIndex - 1, 0)
                } else {
                    selectedIndex = min(selectedIndex + 1, 1)
                }
            })
            NavigationLink{
                ToProfileFeilds()
            } label: {
                Text("Get Started")
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding()
                    .background{
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundColor(.red)
                            .opacity(0.5)
                    }
            }
        }
        .navigationTitle("About Silent Saftey")
    }
}

struct ToProfileFeilds: View {
    var body: some View {
        VStack{
            ProfileFeilds()
            NavigationLink{
                ToWidget()
            } label: {
                Text("Save Profile")
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding()
                    .background{
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundColor(.red)
                            .opacity(0.5)
                    }
            }
        }
    }
}

struct ToWidget: View {
    @State private var selectedIndex = 0
    var body: some View {
        VStack{
            TabView(selection: $selectedIndex) {
                Widget1()
                    .tag(0)
                Widget2()
                    .tag(1)
                Widget3()
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .gesture(DragGesture().onEnded { gesture in
                if gesture.translation.width > 0 {
                    // Swiped right, go to the previous view
                    selectedIndex = max(selectedIndex - 1, 0)
                } else {
                    // Swiped left, go to the next view
                    selectedIndex = min(selectedIndex + 1, 1)
                }
            })
            NavigationLink{
                How2()
                    .navigationTitle("How it works")
            } label: {
                Text("How it works")
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding()
                    .background{
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundColor(.red)
                            .opacity(0.5)
                    }
            }
            .navigationTitle("SOS Widget")
        }
    }
}

extension NSNotification.Name {
    static let additionalMessage = NSNotification.Name("additionalMessage")
}

//                Button {
//                    locMan.fetchUserLocation { streetAddress, location in
//                        if let streetAddress = streetAddress {
//                            print("Street Address: \(streetAddress)")
//                        } else {
//                            print("Failed to get street address.")
//                        }
//                        if let location = location {
//                            print("Latitude: \(location.coordinate.latitude)")
//                            print("Longitude: \(location.coordinate.longitude)")
//                        } else {
//                            print("Failed to get latitude and longitude.")
//                        }
//                    }
//                } label: {
//                    Text("getLoco")
//                        .foregroundColor(.white)
//                }
