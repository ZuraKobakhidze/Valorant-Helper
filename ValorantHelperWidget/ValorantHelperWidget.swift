//
//  ValorantHelperWidget.swift
//  ValorantHelperWidget
//
//  Created by Zura Kobakhidze on 28.03.22.
//

import WidgetKit
import SwiftUI
import Intents
import UIKit

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct ValorantHelperWidgetEntryView : View {

    var body: some View {
        
        ZStack {
            
            Rectangle()
                .fill(Color("valorantBlack"))
                .edgesIgnoringSafeArea(.all)
            
            Image("valorant_helper_background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFit()
            
            VStack {
                
                Spacer()
                Spacer()
                
                ZStack(alignment: .bottom) {
                    
                    Text("Valorant Helper")
                        .font(Font.custom("VALORANT-Regular", size: 14))
                        .foregroundColor(Color("valorantWhite"))
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                        .shadow(color: Color("valorantBlack"), radius: 2)
                        .offset(x: 0, y: -5)
                    
                }
                
            }
            
        }
        
    }
}

@main
struct ValorantHelperWidget: Widget {
    let kind: String = "ValorantHelperWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            ValorantHelperWidgetEntryView()
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

struct ValorantHelperWidget_Previews: PreviewProvider {
    static var previews: some View {
        ValorantHelperWidgetEntryView()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
