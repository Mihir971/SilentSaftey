//
//  AboutApp.swift
//  SilentSafteyV3
//
//  Created by Mihir Thakur on 8/4/23.
//

import SwiftUI

//MARK: - About Views

struct AboutPhone: View {
    var body: some View {
        VStack (alignment: .listRowSeparatorLeading, spacing: 20){
            Image(systemName: "phone")
                .resizable()
                .frame(width: UIScreen.screenWidth - 40, height: UIScreen.screenWidth - 40)
                .foregroundColor(.red.opacity(0.5))
                .padding(.bottom)
            Text("Silent SOS calling")
                .font(.largeTitle)
            Text("Silent Saftey speaks to 911 on your behalf, when you can't")
                .font(.title2)
        }
        .padding(.bottom, 5)
    }
}

struct AboutPhone_Previews: PreviewProvider {
    static var previews: some View {
        AboutPhone()
    }
}

struct AboutLocation: View {
    var body: some View {
        VStack (alignment: .listRowSeparatorLeading, spacing: 20) {
            Image(systemName: "map")
                .resizable()
                .frame(width: UIScreen.screenWidth - 40, height: UIScreen.screenWidth - 40)
                .foregroundColor(.red.opacity(0.5))
                .padding(.bottom)
            Text("Replay live data to 911")
                .font(.largeTitle)
            Text("Silent Saftey delivers you profile, live location, and typed messages to 911.")
                .font(.title2)
        }
        .padding(.bottom, 5)
    }
}

struct AboutLocation_Previews: PreviewProvider {
    static var previews: some View {
        AboutLocation()
    }
}

struct AboutButton: View {
    var body: some View {
        VStack (alignment: .listRowSeparatorLeading, spacing: 20) {
            Image(systemName: "square.fill")
                .resizable()
                .frame(width: UIScreen.screenWidth - 40, height: UIScreen.screenWidth - 40)
                .foregroundColor(.red.opacity(0.5))
                .padding(.bottom)
            Text("Saftey at your FingerTips")
                .font(.largeTitle)
            Text("Initiate a 911 call using the SOS button within the app of the SOS widget")
                .font(.title2)
        }
        .padding(.bottom, 5)
    }
}

struct AboutButton_Previews: PreviewProvider {
    static var previews: some View {
        AboutButton()
    }
}

//MARK: - Widget Views

struct Widget1: View {
    var body: some View {
        VStack (alignment: .listRowSeparatorLeading, spacing: 20) {
            Image(systemName: "square.fill")
                .resizable()
                .frame(width: UIScreen.screenWidth - 40, height: UIScreen.screenWidth - 40)
                .foregroundColor(.red.opacity(0.5))
                .padding(.bottom)
                .overlay{
                    Text("SOS")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
            Text("Add the SOS Widget")
                .font(.largeTitle)
            Text("Hold doen the home screen until all the aps wobble, and tap the plus button in the upper left-hand corner.")
                .font(.title2)
        }
        .padding(.bottom, 5)
    }
}

struct Widget1_Previews: PreviewProvider {
    static var previews: some View {
        Widget1()
    }
}

struct Widget2: View {
    var body: some View {
        VStack (alignment: .listRowSeparatorLeading, spacing: 20) {
            Image(systemName: "square.fill")
                .resizable()
                .frame(width: UIScreen.screenWidth - 40, height: UIScreen.screenWidth - 40)
                .foregroundColor(.red.opacity(0.5))
                .padding(.bottom)
            Text("Search for silent saftey")
                .font(.largeTitle)
            Text("Search for Silent Saftey and select your desired widget size")
                .font(.title2)
        }
        .padding(.bottom, 5)
    }
}

struct Widget2_Previews: PreviewProvider {
    static var previews: some View {
        Widget2()
    }
}

struct Widget3: View {
    var body: some View {
        VStack (alignment: .listRowSeparatorLeading, spacing: 20) {
            Image(systemName: "square.fill")
                .resizable()
                .frame(width: UIScreen.screenWidth - 40, height: UIScreen.screenWidth - 40)
                .foregroundColor(.red.opacity(0.5))
                .padding(.bottom)
            Text("Drag an drop the Widget onto your home screen")
                .font(.largeTitle)
            Text("Tap the widget to initiate a phone call")
                .font(.title2)
        }
        .padding(.bottom, 5)
    }
}

struct Widget3_Previews: PreviewProvider {
    static var previews: some View {
        Widget3()
    }
}

//MARK: - How to Use View

struct How2: View{
    
    var body: some View{
        VStack (alignment: .listRowSeparatorLeading, spacing: 20) {
            Text("Tap a red button to initiate a 911 call")
                .font(.largeTitle)
                .padding(.horizontal)
            Text("You may call the police, firefighters, ambulance or someone of your choice")
                .padding(.horizontal)
            Text("During the call, utilize the textfeild to send messages to the operator")
                .padding(.horizontal)
        }
        .padding(.bottom, 5)
    }
}

struct How2_Previews: PreviewProvider {
    static var previews: some View {
        How2()
    }
}
