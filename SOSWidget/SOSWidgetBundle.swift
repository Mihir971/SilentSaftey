//
//  SOSWidgetBundle.swift
//  SOSWidget
//
//  Created by Mihir Thakur on 8/14/23.
//

import WidgetKit
import SwiftUI

@main
struct SOSWidgetBundle: WidgetBundle {
    var body: some Widget {
        SOSWidget()
        SOSWidgetLiveActivity()
    }
}
