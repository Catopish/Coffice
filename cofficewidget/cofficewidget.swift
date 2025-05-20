//
//  cofficewidget.swift
//  cofficewidget
//
//  Created by Angel on 17/05/25.
//

import WidgetKit
import SwiftUI


struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct cofficewidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color("browna"), // Warna atas (oranye kemerahan)
                    Color("brownb"),
                    Color("brownc")// Warna bawah (peach terang)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image("cofice")
                        .resizable()
                        .offset(x: 90, y: -90)
                               .frame(width: 25, height: 25)
                    Image("maskot 1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                        .offset(x: 10, y: -15)
                    
                }
            }

            VStack(alignment: .leading, spacing: 24) {
                Text("Check what’s\nbrewing around\nthe corner!")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundColor(.brown2)
                    .multilineTextAlignment(.leading)


                Link(destination: URL(string: "coffice://search")!) {
                    HStack (spacing: 4) {
                        Image(systemName:"magnifyingglass")
                            .foregroundColor(.brown)
                            .font(.system(size: 14))
                            
                        Text("Search ")
                            .foregroundColor(.brown)
                            .fontWeight(.medium)
                            .font(.system(size: 14))
                    }
                    
                    .padding(.vertical, 8)
                    .padding(.horizontal, 24)
                    .background(Color.browna)
                    .cornerRadius(20)
                    .padding(.top)
                    
                }
            }
        }
        
        .widgetURL(URL(string: "coffice://search")) // Fallback jika user tap bagian lain
        .padding(-16)
    }
       
}


struct cofficewidget: Widget {
    let kind: String = "cofficewidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            cofficewidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    cofficewidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
